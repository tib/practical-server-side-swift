//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 05..
//

import Vapor
import SwiftHtml

struct AdminDetailPageTemplate: TemplateRepresentable {

    var context: AdminDetailPageContext

    init(_ context: AdminDetailPageContext) {
        self.context = context
    }

    @TagBuilder
    func render(_ req: Request) -> Tag {
        AdminIndexTemplate(.init(title: context.title, breadcrumbs: context.breadcrumbs)) {
            Div {
                Div {
                    H1(context.title)
                    context.navigation.map { LinkTemplate($0).render(req) }
                }
                .class("lead")
               
                Dl {
                    context.fields.map { DetailTemplate($0).render(req) }
                }

                Section {
                    context.actions.map { LinkTemplate($0).render(req) }
                }
            }
            .class("container")
        }
        .render(req)
    }
}


