//
//  ApiServiceInterface.swift
//  MyProject
//
//  Created by Tibor Bodecs on 2020. 05. 15..
//  Copyright © 2020. Tibor Bodecs. All rights reserved.
//

import Foundation
import Combine
import MyProjectApi

struct Page<T: Decodable>: Decodable {
    struct Metadata: Decodable {
        let page: Int
        let per: Int
        let total: Int
    }
    let metadata: Metadata
    let items: [T]
}

protocol ApiServiceInterface: ServiceInterface {

    func getBlogPosts() -> AnyPublisher<Page<BlogPostListObject>, HTTP.Error>
}
