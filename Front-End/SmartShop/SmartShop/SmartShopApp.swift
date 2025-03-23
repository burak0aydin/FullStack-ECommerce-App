//
//  SmartShopApp.swift
//  SmartShop
//
//  Created by Burak Aydın on 19.03.2025.
//

import SwiftUI

@main
struct SmartShopApp: App {
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(\.authenticationController, .development)
        }
    }
}
