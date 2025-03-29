//
//  CheckoutScreen.swift
//  SmartShop
//
//  Created by Burak Aydın on 29.03.2025.
//

import SwiftUI

struct CheckoutScreen: View {
    
    let cart: Cart
    
    @Environment(UserStore.self) private var userStore
    
    var body: some View {
        List {
            VStack(spacing: 10) {
                Text("Place your order")
                    .font(.title3)
                
                HStack {
                    Text("Items:")
                    Spacer()
                    Text(cart.total, format: .currency(code: "USD"))
                }
                
                if let userInfo = userStore.userInfo {
                    Text("Delivering to \(userInfo.fullName)")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(userInfo.address)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    Text("Please update your profile and add the missing information.")
                        .foregroundStyle(.red)
                }
                
            }.padding()
            
            ForEach(cart.cartItems) { cartItem in
                CartItemView(cartItem: cartItem)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CheckoutScreen(cart: Cart.preview)
    }
    .environment(UserStore(httpClient: .development))
    .environment(CartStore(httpClient: .development))
}
