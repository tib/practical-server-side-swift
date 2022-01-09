//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 03..
//

import Vapor
import SwiftHtml

struct AdminDashboardTemplate: TemplateRepresentable {

    var context: AdminDashboardContext
    
    init(_ context: AdminDashboardContext) {
        self.context = context
    }

    @TagBuilder
    func render(_ req: Request) -> Tag {
        AdminIndexTemplate(.init(title: context.title)) {
            Div {
                Section {
                    P(context.icon)
                    H1(context.title)
                    P(context.message)
                }
          
                Div {
                    let widgets: [TemplateRepresentable] = req.invokeAll("admin-widget")
                    widgets.map { $0.render(req) }    
                }
                .class("widgets")
            }
            .id("dashboard")
            .class("container")
        }
        .render(req)
    }
}
