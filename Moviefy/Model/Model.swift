//
//  Model.swift
//  Moviefy
//
//  Created by Henry Calderon on 4/29/20.
//  Copyright © 2020 Adriana González Martínez. All rights reserved.
//

import Foundation

public protocol Model: Codable{
    static var decoder: JSONDecoder{ get }
    static var encoder: JSONEncoder{ get }
}

public extension Model{
    static var decoder: JSONDecoder{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    static var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
}
