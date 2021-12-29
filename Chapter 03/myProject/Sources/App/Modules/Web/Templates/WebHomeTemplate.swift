//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Vapor
import SwiftHtml

struct WebHomeTemplate: TemplateRepresentable {

    var context: WebHomeContext
    
    init(_ context: WebHomeContext) {
        self.context = context
    }

    @TagBuilder
    func render(_ req: Request) -> Tag {
        WebIndexTemplate(.init(title: context.title)) {
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
        }
        .render(req)
    }
}
