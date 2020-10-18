import Vapor
import Leaf

final class BlogPostEditForm: LeafDataRepresentable {

    struct Input: Decodable {
        var id: String
        var title: String
        var slug: String
        var excerpt: String
        var date: String
        var content: String
    }
    
    var id: String? = nil
    var title = StringFormField()
    var slug = StringFormField()
    var excerpt = StringFormField()
    var date = StringFormField()
    var content = StringFormField()
    
    var leafData: LeafData {
        .dictionary([
            "id": .string(id),
            "title": title.leafData,
            "slug": slug.leafData,
            "excerpt": excerpt.leafData,
            "date": date.leafData,
            "content": content.leafData,
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
    }
    
    func validate() -> Bool {
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
        return valid
    }
    
    func read(from model: BlogPostModel)  {
        id = model.id!.uuidString
        title.value = model.title
        slug.value = model.slug
        excerpt.value = model.excerpt
        date.value = DateFormatter.custom.string(from: model.date)
        content.value = model.content
    }
    
    func write(to model: BlogPostModel) {
        model.title = title.value
        model.slug = slug.value
        model.excerpt = excerpt.value
        model.date = DateFormatter.custom.date(from: date.value)!
        model.content = content.value
    }
}
