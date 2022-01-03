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

    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
    
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
                    Dd(dateFormatter.string(from: context.detail.date))
                    
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
