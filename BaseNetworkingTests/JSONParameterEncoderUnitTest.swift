//
//  JSONParameterEncoderUnitTest.swift
//  AssessmentNetworkUnitTests
//
//  Created by Vlad Zhavoronkov  on 7/9/19.
//  Copyright © 2019 Bytepace. All rights reserved.
//

import XCTest

class JSONParameterEncoderUnitTest: XCTestCase {
    let baseURL = URL(string: "https://www.google.com")!
    lazy var request = URLRequest(url: baseURL)
    
    
    override func setUp() {
        super.setUp()
        XCTAssertNoThrow(try JSONParameterEncoder.encode(&request, with: parameters))
    }
    
    func testHttpBody() {
        XCTAssertNotNil(request.httpBody)
    }
}
