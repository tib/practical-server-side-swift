//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

import Vapor
import SwiftHtml

public struct ContentFieldTemplate: TemplateRepresentable {

    public var context: ContentFieldContext
    
    public init(_ context: ContentFieldContext) {
        self.context = context
    }

    @TagBuilder
    public func render(_ req: Request) -> Tag {
        LabelTemplate(context.label).render(req)
        
        Textarea(context.value)
            .name(context.key)
            .placeholder(context.placeholder)
            .class("xl")
        
        if let error = context.error {
            Span(error)
                .class("error")
        }
    }
}
