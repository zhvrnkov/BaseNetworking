//
//  URLParameterEncoderUnitTest.swift
//  AssessmentNetworkUnitTests
//
//  Created by Vlad Zhavoronkov  on 7/9/19.
//  Copyright © 2019 Bytepace. All rights reserved.
//

import XCTest
@testable import BaseNetworkingLibrary

class URLParameterEncoderUnitTest: XCTestCase {
    let baseURL = URL(string: "https://www.google.com")!
    lazy var request = URLRequest(url: baseURL)    
    override func setUp() {
        XCTAssertNoThrow(try URLParameterEncoder.encode(&request, with: parameters))
    }
    
    func testEncode() {
        guard let urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: false) else {
            XCTFail("Components should not be nil")
            return
        }
        
        guard let items = urlComponents.queryItems else {
            XCTFail("Components should have queryItems")
            return
        }
        
        testQueryItemsCount(items)
        testQueryItemsIdention(items)
    }
    
    private func testQueryItemsCount(_ queryItems: [URLQueryItem]) {
        XCTAssertEqual(queryItems.count, parameters.count)
    }
    
    private func testQueryItemsIdention(_ queryItems: [URLQueryItem]) {
        queryItems.forEach { item in
            guard let itemInParameters = parameters[item.name] else {
                XCTFail("urlComponents should be identical to parameters")
                return
            }
            XCTAssertEqual("\(itemInParameters)", item.value, "values should also be identical")
        }
    }
}

