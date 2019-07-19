//
//  JSONParameterEncoder.swift
//  AssessmentNetwork
//
//  Created by Vlad Zhavoronkov  on 7/9/19.
//  Copyright © 2019 Bytepace. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder {
    public static func encode<T: Encodable>(_ urlRequest: inout URLRequest, with body: T) throws {
        do {
            let jsonAsData = try JSONEncoder().encode(body)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setContentType(.json)
            }
        } catch {
            throw error
        }
    }
}
