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

struct ErrorResponse: Codable {
    let message: String?
}
