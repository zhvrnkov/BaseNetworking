//
//  MockEndPoint.swift
//  BaseNetworkingTests
//
//  Created by Vlad Zhavoronkov on 7/10/19.
//  Copyright © 2019 Vlad Zhavoronkov. All rights reserved.
//

import Foundation
@testable import BaseNetworkingLibrary

enum MockEndpoint: String {
    case justRequest
    case requestWithParameters
    case requestWithHeaders
    case requestWithBody
    case requestWithBodyAndNotHeaders
    case requestWothBodyAndParameters
    case requestWithFormData
    
    private static let allStringCases = [
        "justRequest",
        "requestWithParameters",
        "requestWithHeaders",
        "requestWithBody",
        "requestWithBodyAndNotHeaders",
        "requestWothBodyAndParameters",
        "requestWithFormData"
    ]
    
    static var allCases: [MockEndpoint] = MockEndpoint.allStringCases
        .compactMap { MockEndpoint(rawValue: $0) }
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
        case .requestWothBodyAndParameters:
            return .post
        case .requestWithFormData:
            return .post
        }
    }
    var task: HTTPTask {
        let task: HTTPTask
        switch self {
        case .justRequest:
            task = .request
        case .requestWithParameters:
            task = .requestWithParameters(urlParameters: parameters)
        case .requestWithHeaders:
            task = .request
        case .requestWithBody:
            task = .requestWithBody(body: MockEncodable(username: "VladZhavoornkov", password: "Zerstoren"))
        case .requestWithBodyAndNotHeaders:
            task = .requestWithBody(body: MockEncodable(username: "VladZhavoornkov", password: "Zerstoren"))
        case .requestWothBodyAndParameters:
            task = .requestWithParametersAndBody(body: MockEncodable(username: "VladZhavoornkov", password: "Zerstoren"), urlParameters: parameters)
        case .requestWithFormData:
            task = .requestWithFormData(bodyParameters: parameters)
        }
        return task
    }
    var headers: HTTPHeaders? {
        switch self {
        case .justRequest,
             .requestWithParameters,
             .requestWithBody,
             .requestWithBodyAndNotHeaders,
             .requestWothBodyAndParameters,
             .requestWithFormData:
            return nil
        case .requestWithHeaders:
            return ["First": "Foo", "Second": "Bar"]
        }
    }
}

