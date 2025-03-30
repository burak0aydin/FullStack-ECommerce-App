//
//  EnvironmentValues+Extensions.swift
//  SmartShop
//
//  Created by Burak Aydın on 30.03.2025.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    @Entry var paymentController = PaymentController(httpClient: HTTPClient())
    @Entry var uploaderDownloader = UploaderDownloader(httpClient: HTTPClient())
    @Entry var authenticationController = AuthenticationController(httpClient: HTTPClient())
}

