//
//  PagedResults.swift
//  Moviefy
//
//  Created by Henry Calderon on 4/29/20.
//  Copyright © 2020 Adriana González Martínez. All rights reserved.
//

import Foundation

struct PagedResults<T: Model>: Model {
    let page: Int
    let totalPages: Int
    let results: [T]
}

extension PagedResults {
    static var decoder: JSONDecoder { T.decoder }
}
