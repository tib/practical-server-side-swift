import Vapor

struct BlogRouter: RouteCollection {
    
    let frontendController = BlogFrontendController()
    let adminController = BlogPostAdminController()
    
    func boot(routes: RoutesBuilder) throws {
        routes.get("blog", use: frontendController.blogView)
        routes.get(.anything, use: frontendController.postView)

        let posts = routes
            .grouped(UserModel.redirectMiddleware(path: "/"))
            .grouped("admin", "blog", "posts")
            
        posts.get(use: self.adminController.listView)
        posts.get("new", use: adminController.createView)
    }
}
