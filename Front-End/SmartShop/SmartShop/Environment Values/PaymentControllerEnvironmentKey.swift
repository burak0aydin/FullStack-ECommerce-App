//
//  PaymentControllerEnvironmentKey.swift
//  SmartShop
//
//  Created by Burak Aydın on 30.03.2025.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var paymentController = PaymentController(httpClient: HTTPClient())
}
