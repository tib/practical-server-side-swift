import Vapor

final class BlogPostEditForm: Form {
    typealias Model = BlogPostModel

    struct Input: Decodable {
        var id: String
        var title: String
        var slug: String
        var excerpt: String
        var date: String
        var content: String
        var categoryId: String
        var image: File?
        var imageDelete: Bool?
    }
    
    var id: String? = nil
    var title = BasicFormField()
    var slug = BasicFormField()
    var excerpt = BasicFormField()
    var date = BasicFormField()
    var content = BasicFormField()
    var categoryId = SelectionFormField()
    var image = FileFormField()
    
    init() {}
    
    init(req: Request) throws {
        let context = try req.content.decode(Input.self)
        if !context.id.isEmpty {
            self.id = context.id
        }
        self.title.value = context.title
        self.slug.value = context.slug
        self.excerpt.value = context.excerpt
        self.date.value = context.date
        self.content.value = context.content
        self.categoryId.value = context.categoryId

        self.image.delete = context.imageDelete ?? false
        if
            let image = context.image,
            let data = image.data.getData(at: 0, length: image.data.readableBytes),
            !data.isEmpty
        {
            self.image.data = data
        }
    }
    
    func read(from model: Model)  {
        self.id = model.id!.uuidString
        self.title.value = model.title
        self.slug.value = model.slug
        self.excerpt.value = model.excerpt
        self.date.value = DateFormatter.year.string(from: model.date)
        self.content.value = model.content
        self.categoryId.value = model.$category.id.uuidString
        self.image.value = model.image
    }

    func write(to model: Model) {
        model.title = self.title.value
        model.slug = self.slug.value
        model.excerpt = self.excerpt.value
        model.date = DateFormatter.year.date(from: self.date.value)!
        model.content = self.content.value
        model.$category.id = UUID(uuidString: self.categoryId.value)!
        if !self.image.value.isEmpty {
            model.image = self.image.value
        }
        if self.image.delete {
            model.image = ""
        }
    }
    
    func validate(req: Request) -> EventLoopFuture<Bool> {
        var valid = true
        
        if self.title.value.isEmpty {
            self.title.error = "Title is required"
            valid = false
        }
        if self.slug.value.isEmpty {
            self.slug.error = "Slug is required"
            valid = false
        }
        if self.excerpt.value.isEmpty {
            self.excerpt.error = "Excerpt is required"
            valid = false
        }
        if DateFormatter.year.date(from: self.date.value) == nil {
            self.date.error = "Invalid date"
            valid = false
        }
        if self.content.value.isEmpty {
            self.content.error = "Content is required"
            valid = false
        }

        let uuid = UUID(uuidString: self.categoryId.value)
        return BlogCategoryModel.find(uuid, on: req.db)
        .map { model in
            if model == nil {
                self.categoryId.error = "Category identifier error"
                valid = false
            }
            return valid
        }
    }
}
