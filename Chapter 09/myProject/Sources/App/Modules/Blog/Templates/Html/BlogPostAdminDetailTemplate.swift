//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 03..
//

import Vapor
import SwiftHtml

struct BlogPostAdminDetailTemplate: TemplateRepresentable {

    var context: BlogPostAdminDetailContext
    
    init(_ context: BlogPostAdminDetailContext) {
        self.context = context
    }

    @TagBuilder
    func render(_ req: Request) -> Tag {
        AdminIndexTemplate(.init(title: context.title)) {
            Div {
                Section {
                    H1(context.title)
                }
                .class("lead")

                Dl {
                    Dt("Image")
                    Dd {
                        Img(src: context.detail.image, alt: context.detail.title)
                    }
                    
                    Dt("Title")
                    Dd(context.detail.title)
                    
                    Dt("Excerpt")
                    Dd(context.detail.excerpt)
                    
                    Dt("Date")
                    Dd(context.detail.date.description)
                    
                    Dt("Content")
                    Dd(context.detail.content)
                }
            }
            .id("detail")
            .class("container")
        }
        .render(req)
    }
}
