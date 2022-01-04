//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 04..
//

import Vapor
import SwiftHtml

public struct ColumnTemplate: TemplateRepresentable {
    
    var context: ColumnContext

    public init(_ context: ColumnContext) {
        self.context = context
    }

    @TagBuilder
    public func render(_ req: Request) -> Tag {
        Th(context.label)
            .id(context.key)
            .class("field")
    }
}


