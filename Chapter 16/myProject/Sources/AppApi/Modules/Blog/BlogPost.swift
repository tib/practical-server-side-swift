//
//  BlogPost.swift
//
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Foundation

public extension Blog {

    enum Post: ApiModelInterface {
        public typealias Module = Blog
    }
}

public extension Blog.Post {
    
    struct List: Codable {
        public let id: UUID
        public let title: String
        public let slug: String
        public let image: String
        public let excerpt: String
        public let date: Date
        
        public init(id: UUID, title: String, slug: String, image: String, excerpt: String, date: Date) {
            self.id = id
            self.title = title
            self.slug = slug
            self.image = image
            self.excerpt = excerpt
            self.date = date
        }
    }
    
    struct Detail: Codable {
        public let id: UUID
        public let title: String
        public let slug: String
        public let image: String
        public let excerpt: String
        public let date: Date
        public let category: Blog.Category.List
        public let content: String
        
        public init(id: UUID, title: String, slug: String, image: String, excerpt: String, date: Date, category: Blog.Category.List, content: String) {
            self.id = id
            self.title = title
            self.slug = slug
            self.image = image
            self.excerpt = excerpt
            self.date = date
            self.category = category
            self.content = content
        }
    }
    
    struct Create: Codable {
        public let title: String
        public let slug: String
        public let image: String
        public let excerpt: String
        public let date: Date
        public let content: String
        public let categoryId: UUID
        
        public init(title: String, slug: String, image: String, excerpt: String, date: Date, content: String, categoryId: UUID) {
            self.title = title
            self.slug = slug
            self.image = image
            self.excerpt = excerpt
            self.date = date
            self.content = content
            self.categoryId = categoryId
        }
    }
    
    struct Update: Codable {
        public let title: String
        public let slug: String
        public let image: String
        public let excerpt: String
        public let date: Date
        public let content: String
        public let categoryId: UUID
        
        public init(title: String, slug: String, image: String, excerpt: String, date: Date, content: String, categoryId: UUID) {
            self.title = title
            self.slug = slug
            self.image = image
            self.excerpt = excerpt
            self.date = date
            self.content = content
            self.categoryId = categoryId
        }
    }

    struct Patch: Codable {
        public let title: String?
        public let slug: String?
        public let image: String?
        public let excerpt: String?
        public let date: Date?
        public let content: String?
        public let categoryId: UUID?
        
        public init(title: String?, slug: String?, image: String?, excerpt: String?, date: Date?, content: String?, categoryId: UUID?) {
            self.title = title
            self.slug = slug
            self.image = image
            self.excerpt = excerpt
            self.date = date
            self.content = content
            self.categoryId = categoryId
        }
    }
}
