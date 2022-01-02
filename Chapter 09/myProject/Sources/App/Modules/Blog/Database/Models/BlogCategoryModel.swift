//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 31..
//

import Vapor
import Fluent

final class BlogCategoryModel: DatabaseModelInterface {
    typealias Module = BlogModule
    
    static let identifier = "categories"
    
    struct FieldKeys {
        struct v1 {
            static var title: FieldKey { "title" }
        }
    }
    
    @ID() var id: UUID?
    @Field(key: FieldKeys.v1.title) var title: String
    @Children(for: \.$category) var posts: [BlogPostModel]
    
    init() { }
    
    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
}
