import Vapor

struct BlogRouter: RouteCollection {
    
    let frontendController = BlogFrontendController()
    let postsAdminController = BlogPostAdminController()
    let categoriesAdminController = BlogCategoryAdminController()
    
    func boot(routes: RoutesBuilder) throws {
        routes.get("blog", use: frontendController.blogView)
        routes.get(.anything, use: frontendController.postView)

        let blog = routes
            .grouped(UserModel.redirectMiddleware(path: "/"))
            .grouped("admin", "blog")
        
        let posts = blog.grouped("posts")
            
        posts.get(use: postsAdminController.listView)
        posts.get("create", use: postsAdminController.createView)
        posts.post("create", use: postsAdminController.create)
        
        let singlePost = posts.grouped(":id")
        
        singlePost.get("update", use: postsAdminController.updateView)
        singlePost.post("update", use: postsAdminController.update)
        
        singlePost.get("delete", use: postsAdminController.deleteView)
        singlePost.post("delete", use: postsAdminController.delete)
        
        let categories = blog.grouped("categories")
            
        categories.get(use: categoriesAdminController.listView)
//        categories.get("create", use: categoriesAdminController.createView)
//        categories.post("create", use: categoriesAdminController.create)
//        
//        let singleCategory = categories.grouped(":id")
//        
//        singleCategory.get("update", use: categoriesAdminController.updateView)
//        singleCategory.post("update", use: categoriesAdminController.update)
//        
//        singleCategory.get("delete", use: categoriesAdminController.deleteView)
//        singleCategory.post("delete", use: categoriesAdminController.delete)
        
    }
}
