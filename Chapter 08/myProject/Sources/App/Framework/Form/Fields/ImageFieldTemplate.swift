//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

import Vapor
import SwiftHtml

public struct ImageFieldTemplate: TemplateRepresentable {

    public var context: ImageFieldContext
    
    public init(_ context: ImageFieldContext) {
        self.context = context
    }
    
    @TagBuilder
    public func render(_ req: Request) -> Tag {
        
        if let url = context.previewUrl {
            Img(src: url, alt: context.key)
        }

        LabelTemplate(context.label).render(req)
        
        Input()
            .type(.file)
            .key(context.key)
            .class("field")
            .accept(context.accept)
        
        if let temporaryFile = context.data.temporaryFile {
            Input()
                .key(context.key + "TemporaryFileKey")
                .value(temporaryFile.key)
                .type(.hidden)
            
            Input()
                .key(context.key + "TemporaryFileName")
                .value(temporaryFile.name)
                .type(.hidden)
        }
        
        if let key = context.data.originalKey {
            Input()
                .key(context.key + "OriginalKey")
                .value(key)
                .type(.hidden)
        }

        if !context.label.required {
            Input()
                .key(context.key + "ShouldRemove")
                .value(String(true))
                .type(.checkbox)
                .checked(context.data.shouldRemove)

            Label("Remove")
                .for(context.key + "Remove")
        }
        
        if let error = context.error {
            Span(error)
                .class("error")
        }
    }
}
