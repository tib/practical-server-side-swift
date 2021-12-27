//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Vapor
import SwiftHtml

struct BlogPostsTemplate: TemplateRepresentable {
    var context: BlogPostsContext
    
    init(_ context: BlogPostsContext) {
        self.context = context
    }

    @TagBuilder
    func render(_ req: Request) -> Tag {
        WebIndexTemplate(context.title) {
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
        }
        .render(req)
    }
}
