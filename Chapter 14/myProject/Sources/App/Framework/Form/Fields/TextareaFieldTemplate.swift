//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

import Vapor
import SwiftHtml

public struct TextareaFieldTemplate: TemplateRepresentable {
    
    public var context: TextareaFieldContext
    
    public init(_ context: TextareaFieldContext) {
        self.context = context
    }
    
    @TagBuilder
    public func render(_ req: Request) -> Tag {
        LabelTemplate(context.label).render(req)
        
        Textarea(context.value)
            .placeholder(context.placeholder)
            .name(context.key)
        
        if let error = context.error {
            Span(error)
                .class("error")
        }
    }
}
