//
//  URLRequestHelper.swift
//  BaseNetworking
//
//  Created by Vlad Zhavoronkov on 7/10/19.
//  Copyright © 2019 Vlad Zhavoronkov. All rights reserved.
//

import Foundation

public extension URLRequest {
    enum ContentTypes: String {
        case json = "application/json"
        case urlencoded = "application/x-www-form-urlencoded; charset=utf-8"
        case formData = "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW"
    }
    
    mutating func setContentType(_ contentType: ContentTypes) {
        setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
    }
}
