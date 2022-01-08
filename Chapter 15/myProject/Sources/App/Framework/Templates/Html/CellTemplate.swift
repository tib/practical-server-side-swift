//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 04..
//

import Vapor
import SwiftHtml

public struct CellTemplate: TemplateRepresentable {
    
    var context: CellContext
    var rowId: String

    public init(_ context: CellContext, rowId: String) {
        self.context = context
        self.rowId = rowId
    }

    @TagBuilder
    public func render(_ req: Request) -> Tag {
        Td {
            switch context.type {
            case .text:
                if let link = context.link {
                    LinkTemplate(link, pathInfix: rowId).render(req)
                }
                else {
                    Text(context.value)
                }
            case .image:
                if let link = context.link {
                    LinkTemplate(link, pathInfix: rowId) { label in
                        Img(src: context.value, alt: label)
                    }
                    .render(req)
                }
                else {
                    Img(src: context.value, alt: context.value)
                }
            }
        }
        .class("field")
    }
}


