//
//  DataHelper.swift
//  BaseNetworking
//
//  Created by Vlad Zhavoronkov on 7/10/19.
//  Copyright © 2019 Vlad Zhavoronkov. All rights reserved.
//

import Foundation

public extension Data {
    mutating func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
