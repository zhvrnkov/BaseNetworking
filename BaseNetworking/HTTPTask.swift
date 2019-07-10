//
//  HTTPTask.swift
//  AssessmentNetwork
//
//  Created by Vlad Zhavoronkov  on 7/9/19.
//  Copyright © 2019 Bytepace. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

// TODO: Clarify bodyParameters and urlParameters. Does all cases need it?
public enum HTTPTask {
    case request
    case requestWithParameters(bodyParameters: Parameters?,
        urlParameters: Parameters?)
    case requestWithParametersAndBody(bodyParameters: Parameters?,
        urlParameters: Parameters?,
        additionalHeaders: HTTPHeaders?)
    case multipartFormDataRequest(bodyParameters: Parameters,
        additionalHeaders: HTTPHeaders?)
}
