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
    let categoryAdminController = BlogCategoryAdminController()
    
    func boot(routes: RoutesBuilder) throws {
        routes.get("blog", use: controller.blogView)
        routes.get(.anything, use: controller.postView)
        
        let blog = routes
                    .grouped(AuthenticatedUser.redirectMiddleware(path: "/"))
                    .grouped("admin", "blog")
        
        let categories = blog.grouped("categories")
        categories.get(use: categoryAdminController.listView)
        categories.get("create", use: categoryAdminController.createView)
        categories.post("create", use: categoryAdminController.createAction)
        let categoryId = categories.grouped(":categoryId")
        categoryId.get("update", use: categoryAdminController.updateView)
        categoryId.post("update", use: categoryAdminController.updateAction)
        
        let posts = blog.grouped("posts")
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
