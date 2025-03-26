//
//  UserDefaults+Extensions.swift
//  SmartShop
//
//  Created by Burak Aydın on 26.03.2025.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let userId = "userId"
    }
    
    var userId: Int? {
        get {
            let id = integer(forKey: Keys.userId)
            return id == 0 ? nil : id // Return nil if userId hasn't been set
        }
        set {
            set(newValue, forKey: Keys.userId)
        }
    }
}
