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
        posts.post("new", use: adminController.create)
        posts.get(":id", use: self.adminController.updateView)
        posts.post(":id", use: self.adminController.update)
    }
}
