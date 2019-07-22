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
    let body = MockEncodable(username: "VladZhavoronkov", password: "228322")
    
    override func setUp() {
        super.setUp()
        XCTAssertNoThrow(try JSONParameterEncoder.encode(&request, with: body))
    }
    
    func testHttpBody() {
        XCTAssertNotNil(request.httpBody)
    }
    
    func testJsonIdentity() {
        let standartJson = try! JSONEncoder().encode(body)
        let myJson = request.httpBody!
        
        XCTAssertEqual(standartJson, myJson)
    }
}
