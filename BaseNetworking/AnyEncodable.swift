//
//  AnyEncodable.swift
//  BaseNetworking
//
//  Created by Vlad Zhavoronkov  on 7/19/19.
//  Copyright © 2019 Vlad Zhavoronkov. All rights reserved.
//

import Foundation

public struct AnyEncodable: Encodable {
    
    private let encodable: Encodable
    
    public init(_ encodable: Encodable) {
        self.encodable = encodable
    }
    
    public func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}
