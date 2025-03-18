//
//  AuthenticationEnvironmentKey.swift
//  SmartShop
//
//  Created by Burak Aydın on 19.03.2025.
//

import Foundation
import SwiftUI

private struct AuthenticationEnvironmentKey: EnvironmentKey {
    static let defaultValue = AuthenticationController(httpClient: HTTPClient())
}

extension EnvironmentValues {
    
    var authenticationController: AuthenticationController {
        get { self[AuthenticationEnvironmentKey.self] }
        set { self[AuthenticationEnvironmentKey.self] = newValue }
    }
    
}
