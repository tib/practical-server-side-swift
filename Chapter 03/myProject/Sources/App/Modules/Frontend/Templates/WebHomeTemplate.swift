//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Vapor
import SwiftHtml

struct WebHomeTemplate: TemplateRepresentable {

    unowned var req: Request
    var context: WebHomeContext
    
    init(_ req: Request, context: WebHomeContext) {
        self.req = req
        self.context = context
    }

    var tag: Tag {
        WebIndexTemplate(req, context: context.title) {
            Div {
                Section {
                    P("👋")
                    H1("Hello,")
                    P("welcome to my Vapor powered website.")
                }
                .class("lead")

                for value in context.paragraphs {
                    P(value)
                }
                
                A("Read my blog →")
                    .href("/blog/")
            }
            .id("home")
            .class("container")
        }.tag
    }
}
