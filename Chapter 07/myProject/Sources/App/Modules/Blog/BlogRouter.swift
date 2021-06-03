import Vapor

struct BlogRouter: RouteCollection {
    
    let frontendController = BlogFrontendController()
    let postsAdminController = BlogPostAdminController()
    
    func boot(routes: RoutesBuilder) throws {
        routes.get("blog", use: frontendController.blogView)
        routes.get(.anything, use: frontendController.postView)

        let posts = routes
            .grouped(UserModel.redirectMiddleware(path: "/"))
            .grouped("admin", "blog", "posts")
            
        posts.get(use: postsAdminController.listView)
        posts.get("new", use: postsAdminController.createView)
        posts.post("new", use: postsAdminController.create)
        
        let singlePost = posts.grouped(":id")
        
        singlePost.get(use: postsAdminController.updateView)
        singlePost.post(use: postsAdminController.update)
        
        singlePost.get("delete", use: postsAdminController.deleteView)
        singlePost.post("delete", use: postsAdminController.delete)
    }
}
