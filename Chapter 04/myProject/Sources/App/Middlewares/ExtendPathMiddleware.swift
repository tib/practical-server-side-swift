//
//  File.swift
//
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Vapor

struct ExtendPathMiddleware: AsyncMiddleware {

    func respond(to req: Request, chainingTo next: AsyncResponder) async throws -> Response {
        if !req.url.path.hasSuffix("/") && !req.url.path.contains(".") {
            return req.redirect(to: req.url.path + "/", type: .permanent)
        }
        return try await next.respond(to: req)
    }
}
