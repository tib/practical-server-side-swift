//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 31..
//

import Foundation

extension Blog {

    enum Category {
        
    }
}

extension Blog.Category {
    
    struct List: Codable {
        let id: UUID
        let title: String
    }
}
