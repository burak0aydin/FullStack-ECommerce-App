//
//  SmartShopApp.swift
//  SmartShop
//
//  Created by Burak Aydın on 19.03.2025.
//

import SwiftUI

@main
struct SmartShopApp: App {
    
    @State private var productStore = ProductStore(httpClient: HTTPClient())
    @State private var cartStore = CartStore(httpClient: HTTPClient())
    @State private var userStore = UserStore(httpClient: HTTPClient())
    
    @AppStorage("userId") private var userId: String?
    
    private func loadUserInfoAndCart() async {
        
        await cartStore.loadCart()
        
        do {
            
            try await userStore.loadUserInfo()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(\.authenticationController, .development)
                .environment(productStore)
                .environment(cartStore)
                .environment(userStore)
                .environment(\.uploaderDownloader, UploaderDownloader(httpClient: HTTPClient()))
                .task(id: userId) {
                    if userId != nil {
                        await loadUserInfoAndCart()
                    }
                }
        }
    }
}
