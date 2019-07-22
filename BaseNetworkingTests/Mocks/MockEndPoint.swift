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
    case requestWothBodyAndParameters
    
    private static let allStringCases = [
        "justRequest",
        "requestWithParameters",
        "requestWithHeaders",
        "requestWithBody",
        "requestWithBodyAndNotHeaders",
        "requestWothBodyAndParameters"
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
        }
        return .request
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
        case .requestWothBodyAndParameters:
            return nil
        }
    }
}

