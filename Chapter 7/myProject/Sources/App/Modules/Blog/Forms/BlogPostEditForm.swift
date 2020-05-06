import Vapor

final class BlogPostEditForm: Encodable {

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
    
    func read(from model: BlogPostModel)  {
        self.id = model.id!.uuidString
        self.title.value = model.title
        self.slug.value = model.slug
        self.excerpt.value = model.excerpt
        self.date.value = DateFormatter.year.string(from: model.date)
        self.content.value = model.content
    }

    
    func write(to model: BlogPostModel) {
        model.title = self.title.value
        model.slug = self.slug.value
        model.excerpt = self.excerpt.value
        model.date = DateFormatter.year.date(from: self.date.value)!
        model.content = self.content.value
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
        if DateFormatter.year.date(from: self.date.value) == nil {
            self.date.error = "Invalid date"
            valid = false
        }
        if self.content.value.isEmpty {
            self.content.error = "Content is required"
            valid = false
        }
        return valid
    }
}
