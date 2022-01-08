//
//  BlogPost.swift
//
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Foundation

extension Blog {

    enum Post: ApiModelInterface {
        typealias Module = Blog
    }
}

extension Blog.Post {
    
    struct List: Codable {
        let id: UUID
        let title: String
        let slug: String
        let image: String
        let excerpt: String
        let date: Date
    }
    
    struct Detail: Codable {
        let id: UUID
        let title: String
        let slug: String
        let image: String
        let excerpt: String
        let date: Date
        let category: Blog.Category.List
        let content: String
    }
    
    struct Create: Codable {
        let title: String
        let slug: String
        let image: String
        let excerpt: String
        let date: Date
        let content: String
        let categoryId: UUID
    }
    
    struct Update: Codable {
        let title: String
        let slug: String
        let image: String
        let excerpt: String
        let date: Date
        let content: String
        let categoryId: UUID
    }

    struct Patch: Codable {
        let title: String?
        let slug: String?
        let image: String?
        let excerpt: String?
        let date: Date?
        let content: String?
        let categoryId: UUID?
    }
}
