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
    var title = BasicFormField()
    var slug = BasicFormField()
    var excerpt = BasicFormField()
    var date = BasicFormField()
    var content = BasicFormField()
    
    var leafData: LeafData {
        [
            "id": .string(id),
            "title": title.leafData,
            "slug": slug.leafData,
            "excerpt": excerpt.leafData,
            "date": date.leafData,
            "content": content.leafData,
        ]
    }

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
    }
    
    func validate() -> Bool {
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
//        if self.date.formatter.date(from: self.date) == nil {
//            self.date.error = "Invalid date"
//            valid = false
//        }
        if self.content.value.isEmpty {
            self.content.error = "Content is required"
            valid = false
        }
        return valid
    }
    
    func read(from model: BlogPostModel)  {
        self.id = model.id!.uuidString
        self.title.value = model.title
        self.slug.value = model.slug
        self.excerpt.value = model.excerpt
        //self.date.value = DateFormatter.year.string(from: model.date)
        self.content.value = model.content
    }
    
    func write(to model: BlogPostModel) {
        model.title = title.value
        model.slug = slug.value
        model.excerpt = excerpt.value
//        model.date = date.value
        model.content = content.value
    }
}
