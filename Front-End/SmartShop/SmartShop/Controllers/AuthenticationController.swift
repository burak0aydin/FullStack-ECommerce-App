//
//  AuthenticationController.swift
//  SmartShop
//
//  Created by Burak Aydın on 19.03.2025.
//

import Foundation

struct AuthenticationController {
    
    let httpClient: HTTPClient
    
    func register(username: String, password: String) {
        
        let resource = Resource(url: URL, method: .post([]), modelType: ResponseType)
        httpClient.load(resource)
        
    }
    
}

