//
//  ProductDetailScreen.swift
//  SmartShop
//
//  Created by Burak Aydın on 26.03.2025.
//

import SwiftUI

struct ProductDetailScreen: View {
    
    let product: Product
    @Environment(CartStore.self) private var cartStore
    
    @State private var quantity: Int = 1
    
    var body: some View {
        ScrollView {
            AsyncImage(url: product.photoUrl) { img in
                img.resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    .scaledToFit()
            } placeholder: {
                ProgressView("Loading...")
            }
            
            Text(product.name)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(product.description)
                .padding([.top], 5)
            
            Text(product.price, format: .currency(code: "USD"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .bold()
                .padding([.top], 2)
            
            Stepper(value: $quantity) {
                Text("Quantity: \(quantity)")
            }
            
            Button {
                Task {
                    do {
                        try await cartStore.addItemToCart(productId: product.id!, quantity: quantity)
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Add to cart")
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .foregroundStyle(.white)
                    .background(.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
            }

            
        }.padding()
    }
}

#Preview {
    ProductDetailScreen(product: Product.preview)
        .environment(CartStore(httpClient: .development))
}
