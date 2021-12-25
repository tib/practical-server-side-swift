//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Vapor
import SwiftHtml

struct BlogPostTemplate: TemplateRepresentable {

    unowned var req: Request
    var context: BlogPostContext
    
    init(_ req: Request, context: BlogPostContext) {
        self.req = req
        self.context = context
    }

    var tag: Tag {
        WebIndexTemplate(req, context: context.title) {
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
        }.tag
    }
}
