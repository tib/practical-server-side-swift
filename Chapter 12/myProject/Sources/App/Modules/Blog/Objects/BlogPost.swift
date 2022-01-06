//
//  BlogPost.swift
//
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Foundation

extension Blog {

    enum Post {
        
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
}
