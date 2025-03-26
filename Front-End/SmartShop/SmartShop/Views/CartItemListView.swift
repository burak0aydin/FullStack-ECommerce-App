//
//  CartItemListView.swift
//  SmartShop
//
//  Created by Burak Aydın on 26.03.2025.
//

import SwiftUI

struct CartItemListView: View {
    
    let cartItems: [CartItem]
    
    var body: some View {
        ForEach(cartItems) { cartItem in
            CartItemView(cartItem: cartItem)
        }.listStyle(.plain)
    }
}

#Preview {
    CartItemListView(cartItems: Cart.preview.cartItems)
}
