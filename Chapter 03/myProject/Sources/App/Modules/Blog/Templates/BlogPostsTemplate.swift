//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Vapor
import SwiftHtml

struct BlogPostsTemplate: TemplateRepresentable {

    unowned var req: Request
    var context: BlogPostsContext
    
    init(_ req: Request, context: BlogPostsContext) {
        self.req = req
        self.context = context
    }

    var tag: Tag {
        WebIndexTemplate(req, context: context.title) {
            Div {
                Section {
                    P("🔥")
                    H1("Blog")
                    P("Hot news and stories about everything.")
                }
                .class("lead")

                Div {
                    for post in context.posts {
                        Article {
                            A {
                                Img(src: post.image, alt: post.title)
                                H2(post.title)
                                P(post.excerpt)
                            }
                            .href("/\(post.slug)/")
                        }
                    }
                }
                .class("grid-221")
                
            }
            .id("blog")
        }.tag
    }
}
