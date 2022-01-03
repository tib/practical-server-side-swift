//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 03..
//

import Vapor
import SwiftHtml

struct BlogPostAdminDeleteTemplate: TemplateRepresentable {

    var context: BlogPostAdminDeleteContext

    init(_ context: BlogPostAdminDeleteContext) {
        self.context = context
    }

    @TagBuilder
    func render(_ req: Request) -> Tag {
        AdminIndexTemplate(.init(title: context.title)) {
            Div {
                Span("🗑")
                    .class("icon")
                H1(context.title)
                P("You are about to permanently delete the<br>`\(context.name)` \(context.type).")
                
                Form {
                    Input()
                        .type(.submit)
                        .class(["button", "destructive"])
                        .style("display: inline")
                        .value("Delete")
                    
                    A("Cancel")
                        .href("/admin/blog/posts/")
                        .class(["button", "cancel"])
                }
                .method(.post)
                .id("delete-form")
            }
            .class(["lead", "container", "center"])
        }
        .render(req)
    }
}


