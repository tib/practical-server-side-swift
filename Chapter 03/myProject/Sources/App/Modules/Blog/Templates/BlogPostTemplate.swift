//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Vapor
import SwiftHtml

struct BlogPostTemplate: TemplateRepresentable {

    var context: BlogPostContext
    
    init(_ context: BlogPostContext) {
        self.context = context
    }

    @TagBuilder
    func render(_ req: Request) -> Tag {
        WebIndexTemplate(.init(title: context.post.title)) {
            Div {
                Section {
                    P(context.post.date.description)
                    H1(context.post.title)
                    P(context.post.excerpt)
                }
                .class(["lead", "container"])
                
                Img(src: context.post.image, alt: context.post.title)
                
                Article {
                    Text(context.post.content)
                }
                .class("container")
            }
            .id("post")
        }
        .render(req)
    }
}
