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
        
        let posts = routes
                    .grouped(AuthenticatedUser.redirectMiddleware(path: "/"))
                    .grouped("admin", "blog", "posts")
                    
        posts.get(use: postAdminController.listView)
        
        let postId = posts.grouped(":postId")
        
        postId.get(use: postAdminController.detailView)
        
        posts.get("create", use: postAdminController.createView)
        posts.post("create", use: postAdminController.createAction)

        postId.get("update", use: postAdminController.updateView)
        postId.post("update", use: postAdminController.updateAction)
        
        postId.get("delete", use: postAdminController.deleteView)
        postId.post("delete", use: postAdminController.deleteAction)
    }
}
