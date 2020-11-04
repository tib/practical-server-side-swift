import Vapor
import Leaf

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
    var title = StringFormField()
    var slug = StringFormField()
    var excerpt = StringFormField()
    var date = StringFormField()
    var content = StringFormField()
    var category = StringSelectionFormField()
    var image = FileFormField()
    
    var leafData: LeafData {
        .dictionary([
            "id": .string(id),
            "title": title.leafData,
            "slug": slug.leafData,
            "excerpt": excerpt.leafData,
            "date": date.leafData,
            "content": content.leafData,
            "category": category.leafData,
            "image": image.leafData,
        ])
    }

    init() {}

    init(req: Request) throws {
        let context = try req.content.decode(Input.self)
        if !context.id.isEmpty {
            id = context.id
        }
        title.value = context.title
        slug.value = context.slug
        excerpt.value = context.excerpt
        date.value = context.date
        content.value = context.content
        category.value = context.categoryId
        image.delete = context.imageDelete ?? false
        if let img = context.image, let data = img.data.getData(at: 0, length: img.data.readableBytes), !data.isEmpty {
            image.data = data
        }
    }
    
    func validate(req: Request) -> EventLoopFuture<Bool> {
        var valid = true
        
        if title.value.isEmpty {
            title.error = "Title is required"
            valid = false
        }
        if slug.value.isEmpty {
            slug.error = "Slug is required"
            valid = false
        }
        if excerpt.value.isEmpty {
            excerpt.error = "Excerpt is required"
            valid = false
        }
        if DateFormatter.custom.date(from: date.value) == nil {
            date.error = "Invalid date"
            valid = false
        }
        if content.value.isEmpty {
            content.error = "Content is required"
            valid = false
        }
        let uuid = UUID(uuidString: category.value)
        return BlogCategoryModel.find(uuid, on: req.db).map { [unowned self] model in
            if model == nil {
                category.error = "Category identifier error"
                valid = false
            }
            return valid
        }
    }
    
    func read(from model: Model)  {
        id = model.id!.uuidString
        title.value = model.title
        slug.value = model.slug
        excerpt.value = model.excerpt
        date.value = DateFormatter.custom.string(from: model.date)
        content.value = model.content
        category.value = model.$category.id.uuidString
        image.value = model.image
    }
    
    func write(to model: Model) {
        model.title = title.value
        model.slug = slug.value
        model.excerpt = excerpt.value
        model.date = DateFormatter.custom.date(from: date.value)!
        model.content = content.value
        model.$category.id = UUID(uuidString: category.value)!
        if !image.value.isEmpty {
            model.image = image.value
        }
        if image.delete {
            model.image = ""
        }
    }
}
