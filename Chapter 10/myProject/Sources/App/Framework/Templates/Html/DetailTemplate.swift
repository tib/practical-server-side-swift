//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 05..
//

import Vapor
import SwiftHtml

public struct DetailTemplate: TemplateRepresentable {
    
    var context: DetailContext
    

    public init(_ context: DetailContext) {
        self.context = context
    }

    @TagBuilder
    public func render(_ req: Request) -> Tag {
        Dt(context.label)
        switch context.type {
        case .text:
            context.value.isEmpty ? Dd("&nbsp;") : Dd(context.value.replacingOccurrences(of: "\n", with: "<br>"))
        case .image:
            Dd {
                Img(src: context.value, alt: context.label)
            }
        }
    }
}


