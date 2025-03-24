//
//  Errors.swift
//  SmartShop
//
//  Created by Burak Aydın on 24.03.2025.
//

import Foundation

enum ProductSaveError: Error {
    case missingUserId
    case invalidPrice
    case operationFailed(String)
    case missingImage
}

enum UserError: Error {
    case missingId
}
