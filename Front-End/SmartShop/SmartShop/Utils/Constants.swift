//
//  Constants.swift
//  SmartShop
//
//  Created by Burak Aydın on 19.03.2025.
//

import Foundation

struct Constants {
    
    // Base URL configuration
    private static let baseURL: String = {
        #if targetEnvironment(simulator)
            return "http://localhost:8080"  // Simulator can use localhost
        #else
            return "http://192.168.1.95:8080"  // Real device needs network IP
        #endif
    }()
    
    struct Urls {
        static let register: URL = URL(string: "\(baseURL)/api/auth/register")!
        static let login: URL = URL(string: "\(baseURL)/api/auth/login")!
        static let products: URL = URL(string: "\(baseURL)/api/products")!
        static let createProduct: URL = URL(string: "\(baseURL)/api/products")!
        static let uploadProductImage = URL(string: "\(baseURL)/api/products/upload")!
        static let addCartItem = URL(string: "\(baseURL)/api/cart/items")!
        static let loadCart = URL(string: "\(baseURL)/api/cart")!
        static let updateUserInfo = URL(string: "\(baseURL)/api/user")!
        static let loadUserInfo = URL(string: "\(baseURL)/api/user")!
        static let createPaymentIntent = URL(string: "\(baseURL)/api/payment/create-payment-intent")!
        static let createOrder = URL(string: "\(baseURL)/api/orders/create-order")!
        
        static func deleteCartItem(_ cartItemId: Int) -> URL {
            URL(string: "\(baseURL)/api/cart/item/\(cartItemId)")!
        }
        
        static func myProducts(_ userId: Int) -> URL {
            URL(string: "\(baseURL)/api/products/user/\(userId)")!
        }
        
        static func deleteProduct(_ productId: Int) -> URL {
            URL(string: "\(baseURL)/api/products/\(productId)")!
        }
        
        static func updateProduct(_ productId: Int) -> URL {
            URL(string: "\(baseURL)/api/products/\(productId)")!
        }
        
    }
    
}
