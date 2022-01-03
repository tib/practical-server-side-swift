//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 03..
//

import Vapor

struct BlogPostApiController {
    
    func mapList(_ model: BlogPostModel) -> Blog.Post.List {
        .init(id: model.id!,
              title: model.title,
              slug: model.slug,
              image: model.imageKey,
              excerpt: model.excerpt,
              date: model.date)
    }
}
