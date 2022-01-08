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
    }
    
    func adminRoutesHook(_ args: HookArguments) -> Void {
        let routes = args["routes"] as! RoutesBuilder

        postAdminController.setupRoutes(routes)
        categoryAdminController.setupRoutes(routes)
    }
    
    func apiRoutesHook(_ args: HookArguments) -> Void {
        let routes = args["routes"] as! RoutesBuilder

        postApiController.setupRoutes(routes)
        categoryApiController.setupRoutes(routes)
    }
    
    func responseHook(_ args: HookArguments) async throws -> Response? {
        let req = args["req"] as! Request
        return try await frontendController.postView(req: req)
    }
    
}
