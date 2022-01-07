//
//  TemplateRenderer.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Vapor
import SwiftHtml

public struct TemplateRenderer {
    
    var req: Request
    
    init(_ req: Request) {
        self.req = req
    }

    public func renderHtml(_ template: TemplateRepresentable, minify: Bool = false, indent: Int = 4) -> Response {
        let doc = Document(.html) { template.render(req) }
        let body = DocumentRenderer(minify: minify, indent: indent).render(doc)
        return Response(status: .ok, headers: ["content-type": "text/html"], body: .init(string: body))
    }
}

