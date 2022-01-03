//
//  BlogRouter.swift
//
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Vapor

struct BlogRouter: RouteCollection {
    
    let controller = BlogFrontendController()
    let postAdminController = BlogPostAdminController()
    
    func boot(routes: RoutesBuilder) throws {
        routes.get("blog", use: controller.blogView)
        routes.get(.anything, use: controller.postView)
        
        routes
            .grouped(AuthenticatedUser.redirectMiddleware(path: "/"))
            .grouped("admin", "blog")
            .get("posts", use: postAdminController.listView)
    }
}
