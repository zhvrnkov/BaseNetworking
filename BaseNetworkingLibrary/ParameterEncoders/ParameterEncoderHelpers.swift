//
//  ParameterEncoding.swift
//  AssessmentNetwork
//
//  Created by Vlad Zhavoronkov  on 7/9/19.
//  Copyright © 2019 Bytepace. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public enum ParameterEncodingErrors: String, Error {
    case missingURL = "URL is missed"
}
