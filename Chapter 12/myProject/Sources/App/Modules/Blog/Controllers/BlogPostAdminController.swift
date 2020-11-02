import Vapor
import Fluent
import Leaf
import Liquid

struct BlogPostAdminController: AdminViewController {
    typealias Model = BlogCategoryModel
    typealias Model = BlogPostModel
    typealias EditForm = BlogPostEditForm

    private func generateUniqueAssetLocationKey() -> String {
        Model.path + UUID().uuidString + ".jpg"
    }

    func beforeRender(req: Request, form: BlogPostEditForm) -> EventLoopFuture<Void> {
        BlogCategoryModel.query(on: req.db).all()
            .mapEach(\.formFieldStringOption)
            .map { form.category.options = $0 }
    }

    func beforeCreate(req: Request, model: BlogPostModel, form: BlogPostEditForm) -> EventLoopFuture<BlogPostModel> {
        var future: EventLoopFuture<BlogPostModel> = req.eventLoop.future(model)
        if let data = form.image.data {
            let key = generateUniqueAssetLocationKey()
            future = req.fs.upload(key: key, data: data).map { url in
                form.image.value = url
                model.imageKey = key
                model.image = url
                return model
            }
        }
        return future
    }
        
    func beforeUpdate(req: Request, model: BlogPostModel, form: BlogPostEditForm) -> EventLoopFuture<BlogPostModel> {
        var future: EventLoopFuture<BlogPostModel> = req.eventLoop.future(model)
        if
            (form.image.delete || form.image.data != nil),
            let imageKey = model.imageKey
        {
            future = req.fs.delete(key: imageKey).map {
                form.image.value = ""
                model.image = ""
                model.imageKey = nil
                return model
            }
        }
        if let data = form.image.data {
            return future.flatMap { model in
                let key = generateUniqueAssetLocationKey()
                return req.fs.upload(key: key, data: data).map { url in
                    form.image.value = url
                    model.imageKey = key
                    model.image = url
                    return model
                }
            }
        }
        return future
    }

    func beforeDelete(req: Request, model: BlogPostModel) -> EventLoopFuture<BlogPostModel> {
        if let key = model.imageKey {
            return req.fs.delete(key: key).map { model }
        }
        return req.eventLoop.future(model)
    }
}

