//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 01..
//

import Vapor
import SwiftHtml

public struct LabelTemplate: TemplateRepresentable {

    var context: LabelContext

    public init(_ context: LabelContext) {
        self.context = context
    }

    @TagBuilder
    public func render(_ req: Request) -> Tag {
        Label {
            Text(context.title ?? context.key.capitalized)

            if let more = context.more {
                Span(more)
                    .class("more")
            }
            if context.required {
                Span("*")
                    .class("required")
            }
        }.for(context.key)
    }
}
