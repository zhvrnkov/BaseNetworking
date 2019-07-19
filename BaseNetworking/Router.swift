//
//  Router.swift
//  AssessmentNetwork
//
//  Created by Vlad Zhavoronkov  on 7/9/19.
//  Copyright © 2019 Bytepace. All rights reserved.
//

import Foundation

public typealias RouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

final public class Router<EndPoint: EndPointType> {
    private let session = URLSession(configuration: .default)
    private var task: URLSessionTask?
    
    public func request(_ route: EndPoint, completeion: @escaping RouterCompletion) {
        do {
            let request = try Router.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: completeion)
        } catch {
            completeion(nil, nil, error)
        }
        task?.resume()
    }
    
    public func cancel() {
        task?.cancel()
    }
    
    public static func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(
            url: route.baseURL.appendingPathComponent(route.path),
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        addHeaders(route.headers, request: &request)
        do {
            try configure(request: &request, by: route.task)
            return request
        } catch {
            throw error
        }
    }
    
    private static func configure(request: inout URLRequest, by task: HTTPTask) throws {
        do {
            switch task {
            case .request:
                ()
            case .requestWithParameters(let urlParameters):
                try URLParameterEncoder.encode(&request, with: urlParameters)
            case .requestWithBody(let body):
                let any = AnyEncodable(body)
                try JSONParameterEncoder.encode(&request, with: any)
            case .requestWithParametersAndBody(let body, let urlParameters):
                let any = AnyEncodable(body)
                try JSONParameterEncoder.encode(&request, with: any)
                try URLParameterEncoder.encode(&request, with: urlParameters)
            case .reuqestWithFormData(let bodyParameters):
                try MultipartFormDataEncoder.encode(&request, with: bodyParameters)
            }
        } catch {
            throw error
        }
    }
    
    private static func addHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        headers.forEach({ request.setValue($1, forHTTPHeaderField: $0) })
    }
    
    public init() {}
}
