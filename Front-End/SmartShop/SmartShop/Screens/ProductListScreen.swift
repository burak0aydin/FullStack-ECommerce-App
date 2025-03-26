//
//  ProductListScreen.swift
//  SmartShop
//
//  Created by Burak Aydın on 24.03.2025.
//

import SwiftUI

struct ProductListScreen: View {
    
    @Environment(ProductStore.self) private var productStore
    
    var body: some View {
        List(productStore.products) { product in
            
            NavigationLink {
                ProductDetailScreen(product: product)
            } label: {
                ProductCellView(product: product)
                    //.listRowSeparator(.hidden)
            }
           
        }
        .listStyle(.plain)
        .navigationTitle("New Arrivals")
        .task {
            do {
                try await productStore.loadAllProducts()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProductListScreen()
    }
    .environment(ProductStore(httpClient: .development))
    .environment(CartStore(httpClient: .development))
    
}
