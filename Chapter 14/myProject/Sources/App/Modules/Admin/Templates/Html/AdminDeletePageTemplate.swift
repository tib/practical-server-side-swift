//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 05..
//

import Vapor
import SwiftHtml

public struct AdminDeletePageTemplate: TemplateRepresentable {

    var context: AdminDeletePageContext

    public init(_ context: AdminDeletePageContext) {
        self.context = context
    }

    @TagBuilder
    public func render(_ req: Request) -> Tag {
        AdminIndexTemplate(.init(title: context.title, breadcrumbs: context.breadcrumbs)) {
            Div {
                Span("🗑")
                    .class("icon")
                H1(context.title)
                P("You are about to permanently delete the<br>`\(context.name)` \(context.type).")
                
                FormTemplate(context.form).render(req)

                A("Cancel")
                    .href((try? req.query.get(String.self, at: "cancel")) ?? "#")
                    .class(["button", "cancel"])
            }
            .class(["lead", "container", "center"])
        }
        .render(req)
    }
}


