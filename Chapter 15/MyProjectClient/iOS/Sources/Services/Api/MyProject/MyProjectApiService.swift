//
//  MyProjectApiService.swift
//  MyProject
//
//  Created by Tibor Bodecs on 2020. 05. 15..
//  Copyright © 2020. Tibor Bodecs. All rights reserved.
//

import Foundation
import Combine
import MyProjectApi

final class MyProjectApiService: ApiServiceInterface {
   
    let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func getBlogPosts() -> AnyPublisher<Page<BlogPostListObject>, HTTP.Error> {
        let url = URL(string: self.baseUrl + "/blog/posts")!
        var request = URLRequest(url: url)
        request.httpMethod = HTTP.Method.get.rawValue.uppercased()
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return URLSession.shared.dataTaskPublisher(for: request)
        .tryMap { data, response in
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HTTP.Error.invalidResponse
            }
            guard httpResponse.statusCode == 200 else {
                throw HTTP.Error.statusCode(httpResponse.statusCode)
            }
            return data
        }
        .decode(type: Page<BlogPostListObject>.self, decoder: decoder)
        .mapError { error -> HTTP.Error in
            if let httpError = error as? HTTP.Error {
                return httpError
            }
            return HTTP.Error.unknown(error)
        }
        .eraseToAnyPublisher()
    }
}
