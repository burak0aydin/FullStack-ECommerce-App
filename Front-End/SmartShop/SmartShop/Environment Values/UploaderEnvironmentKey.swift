//
//  UploaderEnvironmentKey.swift
//  SmartShop
//
//  Created by Burak Aydın on 24.03.2025.
//

import Foundation
import SwiftUI

private struct UploaderEnvironmentKey: EnvironmentKey {
  static let defaultValue = UploaderDownloader(httpClient: HTTPClient())
}

extension EnvironmentValues {
  var uploaderDownloader: UploaderDownloader {
    get { self[UploaderEnvironmentKey.self] }
    set { self[UploaderEnvironmentKey.self] = newValue }
  }
}
