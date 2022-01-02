//
//  WebLinkTemplate.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 30..
//

import Vapor
import SwiftHtml

struct WebLinkTemplate: TemplateRepresentable {

    var context: WebLinkContext
    
    init(_ context: WebLinkContext) {
        self.context = context
    }

    @TagBuilder
    func render(_ req: Request) -> Tag {
        A(context.label)
            .href(context.url)
    }
}
