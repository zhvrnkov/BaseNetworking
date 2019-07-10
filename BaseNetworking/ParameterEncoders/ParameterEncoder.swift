//
//  ParameterEncoding.swift
//  AssessmentNetwork
//
//  Created by Vlad Zhavoronkov  on 7/9/19.
//  Copyright © 2019 Bytepace. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

// We need to add httpBody to request with bodyParameters (POST) and to add queryItems to
// request with urlParameters (GET). For this we will create JSONParameterEncoder and
// URLParameterEncoder which will conform to that protocol.
public protocol ParameterEncoder {
    static func encode(_ urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum ParameterEncodingErrors: String, Error {
    case missingURL = "URL is missed"
}
