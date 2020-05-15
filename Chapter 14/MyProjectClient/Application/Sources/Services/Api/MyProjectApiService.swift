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

//        let url = URL(string: self.baseUrl + "todos")!
//        var request = URLRequest(url: url)
//        request.httpMethod = HTTP.Method.get.rawValue.uppercased()
//
//        return URLSession.shared.dataTaskPublisher(for: request)
//        .tryMap { data, response in
//            guard let httpResponse = response as? HTTPURLResponse else {
//                throw HTTP.Error.invalidResponse
//            }
//            guard httpResponse.statusCode == 200 else {
//                throw HTTP.Error.statusCode(httpResponse.statusCode)
//            }
//            return data
//        }
//        .decode(type: [TodoObject].self, decoder: JSONDecoder())
//        .mapError { error -> HTTP.Error in
//            if let httpError = error as? HTTP.Error {
//                return httpError
//            }
//            return HTTP.Error.unknown(error)
//        }
//        .eraseToAnyPublisher()
    func getBlogPosts() -> AnyPublisher<Page<BlogPostListObject>, Error> {
        return Future<Page<BlogPostListObject>, Error> { promise in
            
        }
        .eraseToAnyPublisher()
    }
}
