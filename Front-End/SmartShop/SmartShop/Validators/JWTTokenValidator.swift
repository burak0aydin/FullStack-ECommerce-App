//
//  JWTTokenValidator.swift
//  SmartShop
//
//  Created by Burak Aydın on 22.03.2025.
//

import Foundation
import JWTDecode

struct JWTTokenValidator {
    
    static func validate(token: String?) -> Bool {
        
        guard let token = token else { return false }
        
        do {
            let jwt = try decode(jwt: token)
            
            if let expirationDate = jwt.expiresAt {
                let currentDate = Date()
                
                if currentDate >= expirationDate {
                    return false
                } else {
                    return true
                }
            } else {
                return false
            }
            
        } catch {
            return false
        }
    }
    
}
