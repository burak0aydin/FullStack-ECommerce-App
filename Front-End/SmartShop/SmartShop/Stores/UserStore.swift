//
//  UserStore.swift
//  SmartShop
//
//  Created by Burak Aydın on 29.03.2025.
//

import Foundation
import Observation

@MainActor
@Observable
class UserStore {
    
    var userInfo: UserInfo?
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func updateUserInfo(userInfo: UserInfo) async throws {
        
        print("updateUserInfo")
        let userInfoData = try JSONEncoder().encode(userInfo)
        let resource = Resource(url: Constants.Urls.updateUserInfo, method: .put(userInfoData), modelType: UserInfoResponse.self)
        let response = try await httpClient.load(resource)
        
        if let userInfo = response.userInfo, response.success {
            self.userInfo = userInfo
        } else {
            throw UserError.operationFailed(response.message ?? "")
        }
    }
    
}
