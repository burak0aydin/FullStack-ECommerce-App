//
//  Constants.swift
//  SmartShop
//
//  Created by Burak Aydın on 19.03.2025.
//

import Foundation

struct Constants {
    
    struct Urls {
        static let register: URL = URL(string: "http://localhost:8080/api/auth/register")!
        static let login: URL = URL(string: "http://localhost:8080/api/auth/login")!
        static let products: URL = URL(string: "http://localhost:8080/api/products")!
        static let createProduct: URL = URL(string: "http://localhost:8080/api/products")!
        static let uploadProductImage = URL(string: "http://localhost:8080/api/products/upload")!
        static let addCartItem = URL(string: "http://localhost:8080/api/cart/items")!
        
        static func myProducts(_ userId: Int) -> URL {
            URL(string: "http://localhost:8080/api/products/user/\(userId)")!
        }
        
        static func deleteProduct(_ productId: Int) -> URL {
            URL(string: "http://localhost:8080/api/products/\(productId)")!
        }
        
        static func updateProduct(_ productId: Int) -> URL {
            URL(string: "http://localhost:8080/api/products/\(productId)")!
        }
        
    }
    
}
