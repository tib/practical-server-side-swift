import ViewKit

extension BlogPostModel: ViewContextRepresentable {

    struct ViewContext: Encodable {
        var id: String
        var title: String
        var slug: String
        var image: String
        var excerpt: String
        var date: String
        var content: String

        init(model: BlogPostModel) {
            self.id = model.id!.uuidString
            self.title = model.title
            self.slug = model.slug
            self.image = model.image
            self.excerpt = model.excerpt
            self.date = DateFormatter.year.string(from: model.date)
            self.content = model.content
        }
    }

    var viewContext: ViewContext { .init(model: self) }
}
