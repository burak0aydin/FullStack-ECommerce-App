//
//  DTOs.swift
//  SmartShop
//
//  Created by Burak Aydın on 19.03.2025.
//

import Foundation

struct RegisterResponse: Codable {
    let message: String?
    let success: Bool
}

struct LoginResponse: Codable {
    let message: String?
    let token: String?
    let success: Bool
    let userId: Int?
    let username: String?
}

struct UploadDataResponse: Codable {
    let message: String?
    let success: Bool
    let downloadURL: URL?
    
    private enum CodingKeys: String, CodingKey {
        case message, success
        case downloadURL = "downloadUrl"
    }
}

struct Product: Codable, Identifiable, Hashable {
    
    var id: Int?
    let name: String
    let description: String
    let price: Double
    let photoUrl: URL?
    let userId: Int
    
    private enum CodingKeys: String, CodingKey {
        case id, name, description, price
        case photoUrl = "photo_url"
        case userId = "user_id"
    }
}

extension Product {
    
    static var preview: Product {
        Product(id: 7, name: "Mirra Chair", description: "The Mirra chair by Herman Miller is an ergonomic office chair designed for comfort and support. It features an adjustable backrest, seat, and armrests, along with a flexible back that adapts to body movements. The chair's breathable mesh promotes airflow, while its responsive design encourages proper posture, making it ideal for long periods of sitting.", price: 850, photoUrl: URL(string: "http://localhost:8080/api/uploads/chair.png")!, userId: 7)
    }
    
    func encode() -> Data? {
        try? JSONEncoder().encode(self)
    }
    
}

struct ErrorResponse: Codable {
    let message: String?
}

struct CreateProductResponse: Codable {
    let success: Bool
    let product: Product?
    let message: String?
}

struct DeleteProductResponse: Codable {
    let success: Bool
    let message: String?
}

struct UpdateProductResponse: Codable {
    let success: Bool
    let message: String?
    let product: Product?
}

struct Cart: Codable, Hashable {
    var id: Int?
    let userId: Int
    var cartItems: [CartItem] = []
    
    private enum CodingKeys: String, CodingKey {
        case id, cartItems
        case userId = "user_id"
    }
    
    var total: Double {
        cartItems.reduce(0.0, { total, cartItem in
            total + (cartItem.product.price * Double(cartItem.quantity))
        })
    }
    
    var itemsCount: Int {
        cartItems.reduce(0, { total, cartItem  in
            total + cartItem.quantity
        })
    }
}

struct CartItem: Codable, Identifiable, Hashable {
    let id: Int?
    let product: Product
    var quantity: Int = 1
}

struct CartItemResponse: Codable {
    let message: String?
    let success: Bool
    let cartItem: CartItem?
}

struct CartResponse: Codable {
    let success: Bool
    let message: String?
    let cart: Cart?
}

struct DeleteCartItemResponse: Codable {
    let success: Bool
    let message: String?
}

// Previews

extension Cart {
    static var preview: Cart {
        return Cart(
            id: 1,
            userId: 7,
            cartItems: [
                CartItem(
                    id: 1,
                    product: Product(
                        id: 7,
                        name: "Coffee",
                        description: "A rich, aromatic blend of premium coffee beans.",
                        price: 5.99,
                        photoUrl: URL(string: "https://picsum.photos/200/300"),
                        userId: 7
                    ),
                    quantity: 2
                ),
                CartItem(
                    id: 2,
                    product: Product(
                        id: 7,
                        name: "Tea",
                        description: "Refreshing green tea with hints of mint.",
                        price: 3.49,
                        photoUrl: URL(string: "https://picsum.photos/200/300"),
                        userId: 7
                    ),
                    quantity: 1
                ),
                CartItem(
                    id: 3,
                    product: Product(
                        id: 7,
                        name: "Hot Chocolate",
                        description: "Smooth and creamy hot chocolate.",
                        price: 4.99,
                        photoUrl: URL(string: "https://picsum.photos/200/300"),
                        userId: 7
                    ),
                    quantity: 3
                )
            ]
        )
    }
}


struct UserInfo: Codable, Equatable {
    
    let firstName: String?
    let lastName: String?
    let street: String?
    let city: String?
    let state: String?
    let zipCode: String?
    let country: String?
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case zipCode = "zip_code"
        case street, city, state, country
    }
    
    var fullName: String {
        [firstName, lastName]
            .compactMap { $0 }
            .joined(separator: " ")
    }
    
    var address: String {
        [
            street,
            [city, state].compactMap { $0 }.joined(separator: " "),
            zipCode,
            country
        ].compactMap { $0 }.joined(separator: " ")
    }
}

struct UserInfoResponse: Codable {
    let success: Bool
    let message: String?
    let userInfo: UserInfo?
}


// Order and Order Item Models

struct OrderItem: Codable, Hashable, Identifiable {
    var id: Int?
    let product: Product
    var quantity: Int = 1
    
    init(from cartItem: CartItem) {
        self.id = nil
        self.product = cartItem.product
        self.quantity = cartItem.quantity
    }
}

struct Order: Codable, Hashable, Identifiable {
    var id: Int?
    let userId: Int
    let total: Double
    let items: [OrderItem]
    
    init(from cart: Cart) {
        self.id = nil
        self.userId = cart.userId
        self.total = cart.total
        self.items = cart.cartItems.map(OrderItem.init)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, total, items
        case userId = "user_id"
    }
    
    func toRequestBody() -> [String: Any] {
        return [
            "total": total,
            "order_items": items.map { item in
                [
                    "product_id": item.product.id,
                    "quantity": item.quantity
                ]
            }
        ]
    }
}

struct CreatePaymentIntentResponse: Codable {
    let paymentIntentClientSecret: String?
    let customerId: String?
    let customerEphemeralKeySecret: String?
    let publishableKey: String?
    
    private enum CodingKeys: String, CodingKey {
        case publishableKey
        case paymentIntentClientSecret = "paymentIntent"
        case customerId = "customer"
        case customerEphemeralKeySecret = "ephemeralKey"
    }
}

struct SaveOrderResponse: Codable {
    let success: Bool
    let message: String?
}
