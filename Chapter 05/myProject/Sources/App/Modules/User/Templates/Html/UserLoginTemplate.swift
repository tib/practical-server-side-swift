//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 31..
//

import Vapor
import SwiftHtml

struct UserLoginTemplate: TemplateRepresentable {

    var context: UserLoginContext
    
    init(_ context: UserLoginContext) {
        self.context = context
    }

    @TagBuilder
    func render(_ req: Request) -> Tag {
        WebIndexTemplate(.init(title: context.title)) {
            Div {
                Section {
                    P(context.icon)
                    H1(context.title)
                    P(context.message)
                }
                .class("lead")

                Form {
                    if let error = context.error {
                        Section {
                            Span(error)
                                .class("error")
                        }
                    }

                    Section {
                        Label("Email:")
                            .for("email")
                        Input()
                            .key("email")
                            .type(.email)
                            .value(context.email)
                            .class("field")
                    }
                    Section {
                        Label("Password:")
                            .for("password")
                        Input()
                            .key("password")
                            .type(.password)
                            .value(context.password)
                            .class("field")
                    }
                    Section {
                        Input()
                            .type(.submit)
                            .value("Sign in")
                            .class("submit")
                    }
                }
                .action("/sign-in/")
                .method(.post)
            }
            .id("user-login")
            .class("container")
        }
        .render(req)
    }
}
