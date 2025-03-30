//
//  CheckoutScreen.swift
//  SmartShop
//
//  Created by Burak Aydın on 29.03.2025.
//

import SwiftUI
import StripePaymentSheet

struct CheckoutScreen: View {
    
    let cart: Cart
    
    @Environment(\.paymentController) private var paymentController
    @Environment(UserStore.self) private var userStore
    @State private var paymentSheet: PaymentSheet?
    
    private func paymentCompletion(result: PaymentSheetResult) {
        print(result)
    }
    
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
            
            if let paymentSheet {
                
                PaymentSheet.PaymentButton(paymentSheet: paymentSheet, onCompletion: paymentCompletion) {
                    Text("Place your order")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundStyle(.white)
                        .cornerRadius(8)
                        .padding()
                        .buttonStyle(.borderless)
                }
                
            }
            
        }.task {
            do {
                paymentSheet = try await paymentController.preparePaymentSheet(for: cart)
            } catch {
                print(error)
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
    .environment(\.paymentController, PaymentController(httpClient: .development))
}
