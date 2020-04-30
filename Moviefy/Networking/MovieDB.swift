//
//  MovieDB.swift
//  Moviefy
//
//  Created by Henry Calderon on 4/29/20.
//  Copyright © 2020 Adriana González Martínez. All rights reserved.
//

import Foundation

struct MovieDB { // logic specific to the TMDB API
    public static let baseURL = URL(string: "https://api.themoviedb.org/3/")!
    public static var api: APIClient = {
        let configuration = URLSessionConfiguration.default
        let apiKey = "YOUR_API_KEY"
        configuration.httpAdditionalHeaders = [
            "Authorization": "Bearer \(apiKey)"
        ]
        return APIClient(configuration: configuration)
    }()
}

extension Request{
    static func popularMovies(completion: @escaping (Result<PagedResults<Movie>, Error>) -> Void) -> Request{
        Request.basic(baseURL: MovieDB.baseURL, path: "discover/movie", params: [
            URLQueryItem(name: "sort_by", value: "popularity.desc")
        ]){ result in
            result.decoding(PagedResults<Movie>.self, completion: completion)
        }
    }
}

public extension Result where Success == Data, Failure == Error {
    func decoding<M: Model>(_ model: M.Type, completion: @escaping (Result<M, Error>) -> Void) {
      // decode the JSON in the background and call the completion block on the main thread
      DispatchQueue.global().async {
            //Result’s flatMap() method takes the successful case (if it was successful) and applies your block. You can return a new Result that contains a successful value or an error.
            let result = self.flatMap { data -> Result<M, Error> in
                do {
                    let decoder = M.decoder
                    let model = try decoder.decode(M.self, from: data)
                    return .success(model)
                } catch {
                    return .failure(error)
                }
            }
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
