//
//  CartItemQuantityView.swift
//  SmartShop
//
//  Created by Burak Aydın on 26.03.2025.
//

import SwiftUI

enum QuantityChangeType: Equatable {
    case update(Int)
    case delete
}

struct CartItemQuantityView: View {
    
    let cartItem: CartItem
    @State private var quantity: Int = 0
    @State private var quantityChangeType: QuantityChangeType?
    
    @Environment(CartStore.self) private var cartStore
    
    var body: some View {
        HStack {
            Button {
                
                if quantity == 1 {
                    quantityChangeType = .delete
                } else {
                    quantity -= 1
                    quantityChangeType = .update(-1)
                }
                
            } label: {
                Image(systemName: cartItem.quantity == 1 ? "trash" : "minus")
                    .frame(width: 24, height: 24) // Set a fixed frame size
            }
            
            Text("\(cartItem.quantity)")
            
            Button {
                quantity += 1
                quantityChangeType = .update(1)
            } label: {
                Image(systemName: "plus")
            }
        }
        .task(id: quantityChangeType) {
            if let quantityChangeType {
                switch quantityChangeType {
                    case .update(let quantity):
                        do {
                            try await cartStore.updateItemQuantity(productId: cartItem.product.id!, quantity: quantity)
                        } catch {
                            print(error)
                        }
                    case .delete:
                        do {
                            try await cartStore.deleteCartItem(cartItemId: cartItem.id!)
                        } catch {
                            print(error.localizedDescription)
                        }
                }
            }
            
            self.quantityChangeType = nil
        }
        .onAppear(perform: {
            quantity = cartItem.quantity
        })
        .frame(width: 150)
        .background(.gray)
        .foregroundStyle(.white)
        .buttonStyle(.borderedProminent)
        .tint(.gray)
        .cornerRadius(15.0)
    }
}

#Preview {
    CartItemQuantityView(cartItem: Cart.preview.cartItems[0])
        .environment(CartStore(httpClient: .development))
}
