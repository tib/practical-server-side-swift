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
        let url = URL(string: self.baseUrl + "/blog/posts/")!
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

    func siwa(token: String) -> AnyPublisher<UserToken, HTTP.Error> {
        struct Body: Codable {
            enum CodingKeys: String, CodingKey {
                case idToken = "id_token"
            }

            let idToken: String
        }

        let url = URL(string: self.baseUrl + "/user/sign-in-with-apple/")!
        var request = URLRequest(url: url)
        request.httpMethod = HTTP.Method.post.rawValue.uppercased()
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(Body(idToken: token))

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
        .decode(type: UserToken.self, decoder: JSONDecoder())
        .mapError { error -> HTTP.Error in
            if let httpError = error as? HTTP.Error {
                return httpError
            }
            return HTTP.Error.unknown(error)
        }
        .eraseToAnyPublisher()
    }

    func register(deviceToken: String, bearerToken: String) -> AnyPublisher<Void, HTTP.Error> {
        struct Body: Codable {
            let token: String
        }

        let url = URL(string: self.baseUrl + "/user/devices/")!
        var request = URLRequest(url: url)
        request.httpMethod = HTTP.Method.post.rawValue.uppercased()
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(Body(token: deviceToken))

        return URLSession.shared.dataTaskPublisher(for: request)
        .tryMap { data, response in
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HTTP.Error.invalidResponse
            }
            guard httpResponse.statusCode == 200 else {
                throw HTTP.Error.statusCode(httpResponse.statusCode)
            }
            return ()
        }
        .mapError { error -> HTTP.Error in
            if let httpError = error as? HTTP.Error {
                return httpError
            }
            return HTTP.Error.unknown(error)
        }
        .eraseToAnyPublisher()
    }

}
