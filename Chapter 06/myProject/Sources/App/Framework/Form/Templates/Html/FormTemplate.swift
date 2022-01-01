//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 01..
//

import Vapor
import SwiftHtml

public struct FormTemplate: TemplateRepresentable {
    
    var context: FormContext
    
    public init(_ context: FormContext) {
        self.context = context
    }

    @TagBuilder
    public func render(_ req: Request) -> Tag {
        Form {
            if let error = context.error {
                Section {
                    P(error)
                        .class("error")
                }
            }
            context.fields.map { field in
                Section {
                    field.render(req)
                }
            }
        }
        .method(context.action.method)
        .action(context.action.url)
        .enctype(context.action.enctype)
    }
}
