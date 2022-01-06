//
//  BlogPost.swift
//
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Foundation

extension Blog {

    enum Post: ApiModelInterface {
        
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
    }
    
    struct Update: Codable {
        let title: String
        let slug: String
        let image: String
        let excerpt: String
        let date: Date
        let content: String
    }

    struct Patch: Codable {
        let title: String?
        let slug: String?
        let image: String?
        let excerpt: String?
        let date: Date?
        let content: String?
    }
}
