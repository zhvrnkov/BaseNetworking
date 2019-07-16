//
//  ApiRoute.swift
//  AssessmentNetwork
//
//  Created by Vlad Zhavoronkov  on 7/10/19.
//  Copyright © 2019 Bytepace. All rights reserved.
//

import Foundation

public protocol ApiRoute {
    associatedtype EndPoint: EndPointType
    associatedtype CompletionType
    var router: Router<EndPoint> { get }
}
