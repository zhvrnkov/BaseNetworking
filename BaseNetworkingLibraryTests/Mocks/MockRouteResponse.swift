//
//  MockRouteResponse.swift
//  BaseNetworkingTests
//
//  Created by Vlad Zhavoronkov on 7/10/19.
//  Copyright © 2019 Vlad Zhavoronkov. All rights reserved.
//

import Foundation

struct MockRouteResponse: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
    
    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case completed
    }
}
