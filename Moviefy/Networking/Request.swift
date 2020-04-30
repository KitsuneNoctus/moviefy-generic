//
//  Request.swift
//  Moviefy
//
//  Created by Henry Calderon on 4/29/20.
//  Copyright © 2020 Adriana González Martínez. All rights reserved.
//

import Foundation

public struct Request {
    let builder: RequestBuilder
    let completion: (Result<Data, Error>) -> Void

    init(builder: RequestBuilder, completion: @escaping (Result<Data, Error>) -> Void) {
        self.builder = builder
        self.completion = completion
    }
    
    public static func basic(method: HTTPMethod = .get, baseURL: URL, path: String, params: [URLQueryItem]? = nil, completion: @escaping (Result<Data, Error>) -> Void) -> Request {
        let builder = BasicRequestBuilder(method: method, baseURL: baseURL, path: path, params: params)
        return Request(builder: builder, completion: completion)
    }
}
