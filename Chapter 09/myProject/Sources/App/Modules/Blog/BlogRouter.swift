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
        
        let blogApi = routes.grouped([
            UserTokenModel.authenticator(),
            UserModel.guardMiddleware(),
        ]).grouped("api", "blog")

        let categories = blogApi.grouped("categories")
        let categoryApiController = BlogCategoryApiController()
        categoryApiController.setupListRoute(routes: categories)
        categoryApiController.setupGetRoute(routes: categories)
        categoryApiController.setupCreateRoute(routes: categories)
        categoryApiController.setupUpdateRoute(routes: categories)
        categoryApiController.setupPatchRoute(routes: categories)
        categoryApiController.setupDeleteRoute(routes: categories)
        
        let postsApiController = BlogPostApiController()
        postsApiController.setupRoutes(routes: blogApi, on: "posts")
    }
}
