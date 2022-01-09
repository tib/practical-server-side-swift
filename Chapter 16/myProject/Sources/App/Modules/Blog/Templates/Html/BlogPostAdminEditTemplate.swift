//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 03..
//

import Vapor
import SwiftHtml

struct BlogPostAdminEditTemplate: TemplateRepresentable {

    var context: BlogPostAdminEditContext
    
    init(_ context: BlogPostAdminEditContext) {
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

                context.form.render(req)
            }
            .id("edit")
            .class("container")
        }
        .render(req)
    }
}
