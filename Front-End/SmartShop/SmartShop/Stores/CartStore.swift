//
//  cartStore.swift
//  SmartShop
//
//  Created by Burak Aydın on 26.03.2025.
//

import Foundation
import Observation

@MainActor
@Observable
class CartStore {
    
    let httpClient: HTTPClient
    var cart: Cart?
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
}
