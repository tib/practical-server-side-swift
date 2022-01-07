//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 31..
//

import Foundation

extension Blog {

    enum Category: ApiModelInterface {
        typealias Module = Blog
        
        static let pathKey: String = "categories"
    }
}

extension Blog.Category {
    
    struct List: Codable {
        let id: UUID
        let title: String
    }
    
    struct Detail: Codable {
        let id: UUID
        let title: String
    }
    
    struct Create: Codable {
        let title: String
    }
    
    struct Update: Codable {
        let title: String
    }
    
    struct Patch: Codable {
        let title: String?
    }
}
