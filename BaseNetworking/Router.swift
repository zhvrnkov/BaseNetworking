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
        addAditionalHeaders(route.headers, request: &request)
        do {
            switch route.task {
            case .request:
                request.setContentType(.json)
            case .requestWithParameters(let bodyParameters,
                                        let urlParameters):
                try configureParametersLikeJson(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
            case .requestWithParametersAndBody(let bodyParameters,
                                               let urlParameters,
                                               let additionalHeaders):
                addAditionalHeaders(additionalHeaders, request: &request)
                try configureParametersLikeJson(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            case .multipartFormDataRequest(let bodyParameters,
                                           let additionalHeaders):
                addAditionalHeaders(additionalHeaders, request: &request)
                try configureParametersLikeFormData(bodyParameters: bodyParameters, urlParameters: nil, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    private static func configureParametersLikeJson(bodyParameters: Parameters?,
                                     urlParameters: Parameters?,
                                     request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(&request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(&request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    private static func configureParametersLikeFormData(bodyParameters: Parameters?,
                                                    urlParameters: Parameters?,
                                                    request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try MultipartFormDataEncoder.encode(&request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(&request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    private static func addAditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        headers.forEach({ request.setValue($1, forHTTPHeaderField: $0) })
    }
}
