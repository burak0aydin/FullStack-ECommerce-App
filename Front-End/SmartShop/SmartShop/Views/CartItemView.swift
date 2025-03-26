//
//  CartItemView.swift
//  SmartShop
//
//  Created by Burak Aydın on 26.03.2025.
//

import SwiftUI

struct CartItemView: View {
    
    let cartItem: CartItem
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: cartItem.product.photoUrl) { img in
                img.resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView("Loading...")
            }
            Spacer()
                .frame(width: 20)
            VStack(alignment: .leading) {
                Text(cartItem.product.name)
                    .font(.title3)
                Text(cartItem.product.price, format: .currency(code: "USD"))
                
                CartItemQuantityView(cartItem: cartItem)
                
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    CartItemView(cartItem: Cart.preview.cartItems[0])
        .environment(CartStore(httpClient: .development))
}
