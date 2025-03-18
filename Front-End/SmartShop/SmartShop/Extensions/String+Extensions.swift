//
//  String+Extensions.swift
//  SmartShop
//
//  Created by Burak Aydın on 19.03.2025.
//

import Foundation

extension String {
    
    var isEmptyOrWhitespace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}
