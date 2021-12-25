//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Foundation

struct BlogPostsContext: Codable {
    let title: String
    let posts: [BlogPost]
}
