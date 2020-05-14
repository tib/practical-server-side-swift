import ContentApi
import MyProjectApi

extension BlogPostListObject: Content {}
extension BlogPostGetObject: Content {}
extension BlogPostUpsertObject: ValidatableContent {}
extension BlogPostPatchObject: ValidatableContent {}

extension BlogPostModel: ApiRepresentable {

    var listContent: BlogPostListObject {
        .init(id: self.id!,
              title: self.title,
              slug: self.slug,
              image: self.image,
              excerpt: self.excerpt,
              date: self.date)
    }

    var getContent: BlogPostGetObject {
        .init(id: self.id!,
              title: self.title,
              slug: self.slug,
              image: self.image,
              excerpt: self.excerpt,
              date: self.date,
              content: self.content)
    }
    
    private func upsert(_ content: BlogPostUpsertObject) throws {
        self.title = content.title
        self.slug = content.slug
        self.image = content.image
        self.excerpt = content.excerpt
        self.date = content.date
        self.content = content.content
    }

    func create(_ content: BlogPostUpsertObject) throws {
        try self.upsert(content)
    }

    func update(_ content: BlogPostUpsertObject) throws {
        try self.upsert(content)
    }

    func patch(_ content: BlogPostPatchObject) throws {
        self.title = content.title ?? self.title
        self.slug = content.slug ?? self.slug
        self.image = content.image ?? self.image
        self.excerpt = content.excerpt ?? self.excerpt
        self.date = content.date ?? self.date
        self.content = content.content ?? self.content
    }
}
