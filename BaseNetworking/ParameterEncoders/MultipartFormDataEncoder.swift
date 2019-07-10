//
//  MultipartFormDataEncoder.swift
//  AssessmentNetwork
//
//  Created by Vlad Zhavoronkov  on 7/10/19.
//  Copyright © 2019 Bytepace. All rights reserved.
//

import Foundation

public struct MultipartFormDataEncoder: ParameterEncoder {
    public static func encode(_ urlRequest: inout URLRequest, with parameters: Parameters) throws {
        var body = Data()
        let boundary = UUID().uuidString
        
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        for (key, value) in parameters where !(value is Data) {
            body.appendString("--\(boundary)\r\n")
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        let mimetype = "image/jpg"
        for (key, value) in parameters {
            if let imageData = value as? Data {
                let filename = "\(key).jpg"
                
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
                body.appendString("Content-Type: \(mimetype)\r\n\r\n")
                body.append(imageData)
                body.appendString("\r\n")
            }
        }
        body.appendString("--\(boundary)--\r\n")
        
        urlRequest.httpBody = body
    }
}
