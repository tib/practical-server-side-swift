//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

import Vapor
import SwiftHtml

public struct SelectFieldTemplate: TemplateRepresentable {

    public var context: SelectFieldContext
    
    public init(_ context: SelectFieldContext) {
        self.context = context
    }
    
    @TagBuilder
    public func render(_ req: Request) -> Tag {
        LabelTemplate(context.label).render(req)
        
        Select {
            for item in context.options {
                Option(item.label)
                    .value(item.key)
                    .selected(context.value == item.key)
            }
        }
        .name(context.key)
        
        
        if let error = context.error {
            Span(error)
                .class("error")
        }
    }
}
