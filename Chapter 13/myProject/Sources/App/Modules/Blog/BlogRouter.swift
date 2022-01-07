//
//  BlogRouter.swift
//
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Vapor

struct BlogRouter: RouteCollection {
    
    let frontendController = BlogFrontendController()
    
    let postAdminController = BlogPostAdminController()
    let postApiController = BlogPostApiController()
    
    let categoryAdminController = BlogCategoryAdminController()
    let categoryApiController = BlogCategoryApiController()
    
    func boot(routes: RoutesBuilder) throws {
        routes.get("blog", use: frontendController.blogView)
        routes.get(.anything, use: frontendController.postView)
        
        let admin = routes
                    .grouped(AuthenticatedUser.redirectMiddleware(path: "/"))
                    .grouped("admin")

        postAdminController.setupRoutes(admin)
        categoryAdminController.setupRoutes(admin)
        
        let api = routes.grouped("api")
        postApiController.setupRoutes(api)
        categoryApiController.setupRoutes(api)
    }
}
