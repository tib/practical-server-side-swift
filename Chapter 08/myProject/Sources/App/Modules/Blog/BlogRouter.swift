import Vapor

struct BlogRouter: RouteCollection {
    
    let frontendController = BlogFrontendController()
    let adminController = BlogPostAdminController()
    
    func boot(routes: RoutesBuilder) throws {

        routes.get("blog", use: frontendController.blogView)
        routes.get(.anything, use: frontendController.postView)

        let protected = routes.grouped([
            UserModelSessionAuthenticator(),
            UserModel.redirectMiddleware(path: "/")
        ])
        let blog = protected.grouped("admin", "blog")
        let posts = blog.grouped("posts")

        posts.get(use: adminController.listView)
        posts.get("new", use: adminController.createView)
        posts.post("new", use: adminController.create)
        posts.get(":id", use: adminController.updateView)
        posts.post(":id", use: adminController.update)
        posts.post(":id", "delete", use: adminController.delete)
    }
}
