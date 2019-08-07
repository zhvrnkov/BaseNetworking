//
//  MockRoute.swift
//  BaseNetworkingTests
//
//  Created by Vlad Zhavoronkov on 7/10/19.
//  Copyright © 2019 Vlad Zhavoronkov. All rights reserved.
//

import Foundation
@testable import BaseNetworkingLibrary

fileprivate func handleNetwork(response: HTTPURLResponse) -> Result<Void, Error> {
    switch response.statusCode {
    case 200...299: return .success(())
    case 400...500: return .failure(MockErrors.bad)
    case 501...599: return .failure(MockErrors.bad)
    case 600: return .failure(MockErrors.bad)
    default: return .failure(MockErrors.bad)
    }
}

enum MockErrors: String, Error {
    case noData
    case bad
}

final class MockApiRoute: ApiRoute {
    typealias EndPoint = MockEndpoint
    var router = Router<MockEndpoint>()
    
    func testRequest(completion: @escaping (_ res: Result<MockRouteResponse, Error>) -> Void) {
        router.request(.justRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let response = response as? HTTPURLResponse {
                let result = handleNetwork(response: response)
                switch result {
                case .success(_):
                    guard let responseData = data else {
                        completion(.failure(MockErrors.noData))
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(MockRouteResponse.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
