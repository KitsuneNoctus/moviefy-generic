//
//  RequestBuilder.swift
//  Moviefy
//
//  Created by Henry Calderon on 4/29/20.
//  Copyright © 2020 Adriana González Martínez. All rights reserved.
//

import Foundation

public enum HTTPMethod: String{
    case get
    case post
    case put
    case delete
}

public protocol RequestBuilder{
    var method: HTTPMethod { get }
    var baseURL: URL { get }
    var path: String { get }
    var params: [URLQueryItem]? { get }
    var headers: [String: String] { get }

    func toURLRequest() -> URLRequest
}

public extension RequestBuilder{
    func toURLRequest() -> URLRequest{
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        components.queryItems = params
        let url = components.url!
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue.uppercased()
        return request
    }
}

struct BasicRequestBuilder: RequestBuilder {
    var method: HTTPMethod
    var baseURL: URL
    var path: String
    var params: [URLQueryItem]?
    var headers: [String : String] = [:]
}
