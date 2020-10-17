//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2020. 10. 14..
//

import Vapor
import Leaf

struct DropLeafCacheMiddleware: Middleware {
    
    func respond(to req: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        if !req.application.environment.isRelease {
            LeafEngine.cache.dropAll()
        }
        return next.respond(to: req)
    }
}
