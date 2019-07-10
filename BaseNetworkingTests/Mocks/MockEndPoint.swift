//
//  MockEndPoint.swift
//  BaseNetworkingTests
//
//  Created by Vlad Zhavoronkov on 7/10/19.
//  Copyright © 2019 Vlad Zhavoronkov. All rights reserved.
//

import Foundation

enum MockEndpoint: String {
    case justRequest
    case requestWithParameters
    case requestWithHeaders
    case requestWithBody
    case requestWithBodyAndNotHeaders
    case requestWithNotHeadersButWithAdditionalHeaders
    
    private static let allStringCases = [
        "justRequest",
        "requestWithHeaders",
        "requestWithBody",
        "requestWithBodyAndNotHeaders",
        "requestWithNotHeadersButWithAdditionalHeaders"
    ]
    
    static var allCases: [MockEndpoint] = MockEndpoint.allStringCases.compactMap { MockEndpoint(rawValue: $0) }
}

extension MockEndpoint: EndPointType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    var path: String {
        switch self {
        case .justRequest:
            return "todos/1"
        default:
            return rawValue
        }
    }
    var httpMethod: HTTPMethod {
        switch self {
        case .justRequest:
            return .get
        case .requestWithParameters:
            return .post
        case .requestWithHeaders:
            return .put
        case .requestWithBody:
            return .delete
        case .requestWithBodyAndNotHeaders:
            return .get
        case .requestWithNotHeadersButWithAdditionalHeaders:
            return .get
        }
    }
    var task: HTTPTask {
        switch self {
        case .justRequest:
            return .request
        case .requestWithParameters:
            return .requestWithParameters(bodyParameters: nil, urlParameters: parameters)
        case .requestWithHeaders:
            return .request
        case .requestWithBody:
            return .requestWithParametersAndBody(bodyParameters: parameters, urlParameters: nil, additionalHeaders: nil)
        case .requestWithBodyAndNotHeaders:
            return .requestWithParametersAndBody(bodyParameters: parameters, urlParameters: nil, additionalHeaders: nil)
        case .requestWithNotHeadersButWithAdditionalHeaders:
            return .requestWithParametersAndBody(bodyParameters: nil, urlParameters: nil, additionalHeaders: ["foo": "bar"])
        }
    }
    var headers: HTTPHeaders? {
        switch self {
        case .justRequest:
            return nil
        case .requestWithParameters:
            return nil
        case .requestWithHeaders:
            return ["First": "Foo", "Second": "Bar"]
        case .requestWithBody:
            return nil
        case .requestWithBodyAndNotHeaders:
            return nil
        case .requestWithNotHeadersButWithAdditionalHeaders:
            return nil
        }
    }
}

