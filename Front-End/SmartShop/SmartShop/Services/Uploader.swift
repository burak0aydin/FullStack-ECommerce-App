//
//  Uploader.swift
//  SmartShop
//
//  Created by Burak Aydın on 24.03.2025.
//

import Foundation

enum MimeType: String {
    case jpg = "image/jpg"
    case png = "image/png"
    
    var value: String {
        return self.rawValue
    }
}

struct Uploader {
    
    let httpClient: HTTPClient
    
    func upload(data: Data, mimeType: MimeType = .png) async throws -> UploadDataResponse {
        
        let boundary = UUID().uuidString
        let headers = ["Content-Type": "multipart/form-data; boundry=\(boundary)"]
        
        // create multi part form data body
        let body = createMultipartFormDataBody(data: data, boundary: boundary)
        let resource = Resource(url: Constants.Urls.uploadProductImage, method: .post(body), headers: headers, modelType: UploadDataResponse.self)
        let response = try await httpClient.load(resource)
        return response
    }
    
    private func createMultipartFormDataBody(data: Data, mimeType: MimeType = .png, boundary: String) -> Data {
        
        var body = Data()
        let lineBreak = "\r\n"
        
        body.append("--\(boundary)\(lineBreak)".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"upload.png\"\(lineBreak)".data(using: .utf8)!)
        body.append("Content-Type: \(mimeType.value)\(lineBreak)\(lineBreak)".data(using: .utf8)!)
        body.append(data)
        body.append(lineBreak.data(using: .utf8)!)
        // Add the closing boundary
        body.append("--\(boundary)--\(lineBreak)".data(using: .utf8)!)
        return body
    }
    
}
