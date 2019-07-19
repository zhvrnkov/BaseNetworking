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
    case requestWithParameters(urlParameters: Parameters)
    case requestWithBody(body: Encodable)
    case requestWithParametersAndBody(body: Encodable,
        urlParameters: Parameters)
    // TODO: Write UnitTests for this case
    case reuqestWithFormData(bodyParameters: Parameters)
}
