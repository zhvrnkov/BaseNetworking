//
//  URLParameterEncoder.swift
//  AssessmentNetwork
//
//  Created by Vlad Zhavoronkov  on 7/9/19.
//  Copyright © 2019 Bytepace. All rights reserved.
//

import Foundation

public struct URLParameterEncoder {
    public static func encode(_ urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else {
            throw ParameterEncodingErrors.missingURL
        }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            !parameters.isEmpty {
            urlComponents.queryItems = getQueryItems(from: parameters)
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setContentType(.urlencoded)
        }
    }
    
    private static func getQueryItems(from parameters: Parameters) -> [URLQueryItem] {
        return parameters.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }
    }
}
