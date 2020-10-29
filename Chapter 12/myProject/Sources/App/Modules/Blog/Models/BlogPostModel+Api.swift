import Vapor
import MyProjectApi

extension BlogPostListObject: Content {}
extension BlogPostGetObject: Content {}
extension BlogPostUpsertObject: ValidatableContent {}
extension BlogPostPatchObject: ValidatableContent {}

extension BlogPostModel: ApiRepresentable {

    var listContent: BlogPostListObject {
        .init(id: id!,
              title: title,
              slug: slug,
              image: image,
              excerpt: excerpt,
              date: date)
    }

    var getContent: BlogPostGetObject {
        .init(id: id!,
              title: title,
              slug: slug,
              image: image,
              excerpt: excerpt,
              date: date,
              content: content)
    }
    
    private func upsert(_ object: BlogPostUpsertObject) throws {
        title = object.title
        slug = object.slug
        image = object.image
        excerpt = object.excerpt
        date = object.date
        content = object.content
    }

    func create(_ object: BlogPostUpsertObject) throws {
        try upsert(object)
    }

    func update(_ object: BlogPostUpsertObject) throws {
        try upsert(object)
    }

    func patch(_ object: BlogPostPatchObject) throws {
        title = object.title ?? title
        slug = object.slug ?? slug
        image = object.image ?? image
        excerpt = object.excerpt ?? excerpt
        date = object.date ?? date
        content = object.content ?? content
    }
}
