import Vapor

struct BlogRouter: RouteCollection {
    
    let frontendController = BlogFrontendController()
    let postsAdminController = BlogPostAdminController()
    let categoriesAdminController = BlogCategoryAdminController()
    
    func boot(routes: RoutesBuilder) throws {
        routes.get(BlogModule.pathComponent, use: frontendController.blogView)
        routes.get(.anything, use: frontendController.postView)

        let blog = routes
            .grouped(UserModel.redirectMiddleware(path: "/"))
            .grouped("admin", BlogModule.pathComponent)
        
        let posts = blog.grouped(BlogPostModel.pathComponent)
            
        posts.get(use: postsAdminController.listView)
        posts.get(BlogPostModel.createPathComponent, use: postsAdminController.createView)
        posts.post(BlogPostModel.createPathComponent, use: postsAdminController.create)
        
        let singlePost = posts.grouped(BlogPostModel.idPathComponent)
        
        singlePost.get(BlogPostModel.updatePathComponent, use: postsAdminController.updateView)
        singlePost.post(BlogPostModel.updatePathComponent, use: postsAdminController.update)
        
        singlePost.get(BlogPostModel.deletePathComponent, use: postsAdminController.deleteView)
        singlePost.post(BlogPostModel.deletePathComponent, use: postsAdminController.delete)
        
        let categories = blog.grouped(BlogCategoryModel.pathComponent)
            
        categories.get(use: categoriesAdminController.listView)
        categories.get(BlogCategoryModel.createPathComponent, use: categoriesAdminController.createView)
        categories.post(BlogCategoryModel.createPathComponent, use: categoriesAdminController.create)
        
        let singleCategory = categories.grouped(BlogCategoryModel.idPathComponent)
        
        singleCategory.get(BlogCategoryModel.updatePathComponent, use: categoriesAdminController.updateView)
        singleCategory.post(BlogCategoryModel.updatePathComponent, use: categoriesAdminController.update)
        
        singleCategory.get(BlogCategoryModel.deletePathComponent, use: categoriesAdminController.deleteView)
        singleCategory.post(BlogCategoryModel.deletePathComponent, use: categoriesAdminController.delete)
        
    }
}
