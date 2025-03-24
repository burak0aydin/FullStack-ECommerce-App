//
//  UploaderEnvironmentKey.swift
//  SmartShop
//
//  Created by Burak Aydın on 24.03.2025.
//

import Foundation
import SwiftUI

private struct UploaderEnvironmentKey: EnvironmentKey {
  static let defaultValue = Uploader(httpClient: HTTPClient())
}

extension EnvironmentValues {
  var uploader: Uploader {
    get { self[UploaderEnvironmentKey.self] }
    set { self[UploaderEnvironmentKey.self] = newValue }
  }
}
