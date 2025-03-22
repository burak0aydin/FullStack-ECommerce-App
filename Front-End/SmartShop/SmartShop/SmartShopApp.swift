//
//  SmartShopApp.swift
//  SmartShop
//
//  Created by Burak Aydın on 19.03.2025.
//

import SwiftUI

@main
struct SmartShopApp: App {
    
    @State private var token: String?
    @State private var isLoading: Bool = true
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                
                Group {
                    if isLoading {
                        ProgressView("Loading...")
                    } else {
                        if JWTTokenValidator.validate(token: token) {
                            Text("HomeScreen")
                        } else {
                            LoginScreen()
                        }
                    }
                   
                }
                
            }.environment(\.authenticationController, .development)
                .onAppear(perform: {
                    token = Keychain.get("jwttoken")
                    isLoading = false
                })
        }
    }
}
