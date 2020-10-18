import Vapor

struct BlogRouter: RouteCollection {
    
    let frontendController = BlogFrontendController()
    let postAdminController = BlogPostAdminController()
    let categoryAdminController = BlogCategoryAdminController()
    
    func boot(routes: RoutesBuilder) throws {

        routes.get("blog", use: frontendController.blogView)
        routes.get(.anything, use: frontendController.postView)

        let protected = routes.grouped([
            UserModelSessionAuthenticator(),
            UserModel.redirectMiddleware(path: "/")
        ])
        let blog = protected.grouped("admin", "blog")
        
        postAdminController.setupRoutes(on: blog, as: "posts")
        categoryAdminController.setupRoutes(on: blog, as: "categories")
    }
}
