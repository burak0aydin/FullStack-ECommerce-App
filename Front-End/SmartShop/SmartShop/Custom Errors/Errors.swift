//
//  Errors.swift
//  SmartShop
//
//  Created by Burak Aydın on 24.03.2025.
//

import Foundation

enum ProductError: Error {
    case missingUserId
    case invalidPrice
    case operationFailed(String)
    case missingImage
    case uploadFailed(String)
}

enum UserError: Error {
    case missingId
}
