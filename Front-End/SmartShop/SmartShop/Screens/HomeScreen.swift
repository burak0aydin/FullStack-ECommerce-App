//
//  HomeScreen.swift
//  SmartShop
//
//  Created by Burak Aydın on 24.03.2025.
//

import SwiftUI

enum AppScreen: Hashable, Identifiable, CaseIterable {
    case home
    case myProducts
    case cart
    case profile
    
    var id: AppScreen { self }
}

extension AppScreen {
    
    @ViewBuilder
    var label: some View {
        switch self {
            case .home:
                Label("Home", systemImage: "heart")
            case .myProducts:
                Label("My Products", systemImage: "star")
            case .cart:
                Label("Cart", systemImage: "cart")
            case .profile:
                Label("Profile", systemImage: "person.fill")
        }
    }
    
    @MainActor
    @ViewBuilder
    var destination: some View {
        switch self {
            case .home:
                ProductListScreen()
            case .myProducts:
                NavigationStack {
                    MyProductListScreen()
                        .requiresAuthentication()
                }
            case .cart:
                NavigationStack {
                    Text("Cart")
                        .requiresAuthentication()
                }
            case .profile:
                NavigationStack {
                    ProfileScreen()
                        .requiresAuthentication()
                }
        }
    }
    
}

struct HomeScreen: View {
    
    @State var selection: AppScreen?
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(AppScreen.allCases) { screen in
                screen.destination
                    .tag(screen as AppScreen?)
                    .tabItem { screen.label }
            }
        }
    }
}

#Preview {
    HomeScreen()
        .environment(ProductStore(httpClient: .development))
}
