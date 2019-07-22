//
//  MultipartFormDataEncoderUnitTest.swift
//  BaseNetworkingTests
//
//  Created by Vlad Zhavoronkov on 7/10/19.
//  Copyright © 2019 Vlad Zhavoronkov. All rights reserved.
//

import XCTest

class MultipartFormDataEncoderUnitTest: XCTestCase {
    let baseURL = URL(string: "https://www.google.com")!
    lazy var request = URLRequest(url: baseURL)
    override func setUp() {
        XCTAssertNoThrow(try MultipartFormDataEncoder.encode(&request, with: parameters))
    }
    
    func testHttpBodySetting() {
        XCTAssertNotNil(request.httpBody, "which means that parameters haven't been setted")
    }
}
