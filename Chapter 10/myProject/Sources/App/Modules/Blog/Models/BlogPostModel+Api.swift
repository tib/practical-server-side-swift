import Vapor

extension BlogPostModel: ApiRepresentable {

    struct ListItem: Content {
        var id: UUID
        var title: String
        var slug: String
        var image: String
        var excerpt: String
        var date: Date
    }

    struct GetContent: Content {
        var id: UUID
        var title: String
        var slug: String
        var image: String
        var excerpt: String
        var date: Date
        var content: String
    }
    
    struct UpsertContent: ValidatableContent {
        var title: String
        var slug: String
        var image: String
        var excerpt: String
        var date: Date
        var content: String
    }

    struct PatchContent: ValidatableContent {
        var title: String?
        var slug: String?
        var image: String?
        var excerpt: String?
        var date: Date?
        var content: String?
    }
    
    var listContent: ListItem {
        .init(id: id!,
              title: title,
              slug: slug,
              image: image,
              excerpt: excerpt,
              date: date)
    }

    var getContent: GetContent {
        .init(id: id!,
              title: title,
              slug: slug,
              image: image,
              excerpt: excerpt,
              date: date,
              content: content)
    }
    
    private func upsert(_ newValue: UpsertContent) throws {
        title = newValue.title
        slug = newValue.slug
        image = newValue.image
        excerpt = newValue.excerpt
        date = newValue.date
        content = newValue.content
    }

    func create(_ content: UpsertContent) throws {
        try upsert(content)
    }

    func update(_ content: UpsertContent) throws {
        try upsert(content)
    }

    func patch(_ newValue: PatchContent) throws {
        title = newValue.title ?? title
        slug = newValue.slug ?? slug
        image = newValue.image ?? image
        excerpt = newValue.excerpt ?? excerpt
        date = newValue.date ?? date
        content = newValue.content ?? content
    }
}
