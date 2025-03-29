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
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(\.authenticationController, .development)
                .environment(productStore)
                .environment(cartStore)
                .environment(userStore)
                .environment(\.uploaderDownloader, UploaderDownloader(httpClient: HTTPClient()))
                .task(id: userId) {
                    do {
                        if userId != nil {
                            try await cartStore.loadCart()
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
        }
    }
}
