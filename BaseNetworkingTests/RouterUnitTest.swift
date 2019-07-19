//
//  RouterUnitTest.swift
//  AssessmentNetworkUnitTests
//
//  Created by Vlad Zhavoronkov  on 7/9/19.
//  Copyright © 2019 Bytepace. All rights reserved.
//

import XCTest

class RouterUnitTest: XCTestCase {
    let requestBuilder = Router<MockEndpoint>.buildRequest
    var casesAndOutputs: (cases: [MockEndpoint], outputs: [URLRequest])!
    var cases: [MockEndpoint] {
        return casesAndOutputs.cases
    }
    var outputs: [URLRequest] {
        return casesAndOutputs.outputs
    }
    
    override func setUp() {
        super.setUp()
        casesAndOutputs = getCheckedCasesAndOutputs()
    }
    
    func testUrlsRequestIsNotNil() {
        let urls = outputs.map { $0.url }
        urls.forEach { XCTAssertNotNil($0) }
    }
    
    func testHttpMethodSet() {
        let httpsMethodsFromCases = cases.map { $0.httpMethod.rawValue }
        let httpMethodsFromOutput = outputs.map { $0.httpMethod }
        XCTAssertEqual(httpMethodsFromOutput, httpsMethodsFromCases)
    }

    func testHeadersSet() {
        for index in cases.indices {
            let mockCase = cases[index]
            let request = outputs[index]
            mockCase.headers?.forEach { key, value in
                let headerValue = request.value(forHTTPHeaderField: key)
                XCTAssertEqual(headerValue, value, "\(headerValue ?? "nil") should be equal to \(value)")
            }
        }
    }
    
    func testRequestQueryItems() {
        let components = getCheckedComponents(of: outputs)
        for index in cases.indices {
            let task = cases[index].task
            let components = components[index].queryItems
            
            switch task {
            case .request:
                XCTAssertNil(components)
            case .requestWithParameters(let up):
                XCTAssertEqual(components == nil, up == nil)
            case .requestWithParametersAndBody(_, let up):
                XCTAssertEqual(components == nil, up == nil)
            default:
                ()
            }
        }
    }
    
    func testRequest() {
        let sema = DispatchSemaphore(value: 0)
        DispatchQueue.global().async {
            MockApiRoute().testRequest { result in
                switch result {
                case .success(_):
                    sema.signal()
                case .failure(_):
                    XCTFail()
                    sema.signal()
                }
            }
        }
        sema.wait()
    }
    
    private func getCheckedCasesAndOutputs() -> (cases: [MockEndpoint], outputs: [URLRequest]) {
        let cases = MockEndpoint.allCases
        let outputs = cases.map { getCheckedRequest(of: $0) }
        XCTAssertEqual(cases.count, outputs.count)
        return (cases, outputs)
    }
    
    private func getCheckedRequest(of type: MockEndpoint) -> URLRequest {
        let output = try? requestBuilder(type)
        XCTAssertNotNil(output, "Errors are here")
        return output!
    }
    
    private func getCheckedComponents(of requests: [URLRequest]) -> [URLComponents] {
        let components = requests.compactMap { URLComponents(url: $0.url!, resolvingAgainstBaseURL: false) }
        XCTAssertEqual(components.count, requests.count)
        return components
    }
}
