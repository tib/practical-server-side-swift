import Vapor
import Fluent
import ViewKit
import ContentApi
import ViperKit

final class BlogPostModel: ViperModel {
    typealias Module = BlogModule
    
    static let name: String = "posts"

    struct FieldKeys {
        static var title: FieldKey { "title" }
        static var slug: FieldKey { "slug" }
        static var imageKey: FieldKey { "image_key" }
        static var image: FieldKey { "image" }
        static var excerpt: FieldKey { "excerpt" }
        static var date: FieldKey { "date" }
        static var content: FieldKey { "content" }
        static var categoryId: FieldKey { "category_id" }
    }
    
    @ID() var id: UUID?
    @Field(key: FieldKeys.title) var title: String
    @Field(key: FieldKeys.slug) var slug: String
    @Field(key: FieldKeys.imageKey) var imageKey: String?
    @Field(key: FieldKeys.image) var image: String
    @Field(key: FieldKeys.excerpt) var excerpt: String
    @Field(key: FieldKeys.date) var date: Date
    @Field(key: FieldKeys.content) var content: String
    @Parent(key: FieldKeys.categoryId) var category: BlogCategoryModel

    init() { }

    init(id: UUID? = nil,
         title: String,
         slug: String,
         imageKey: String? = nil,
         image: String,
         excerpt: String,
         date: Date,
         content: String,
         categoryId: UUID)
    {
        self.id = id
        self.title = title
        self.slug = slug
        self.imageKey = imageKey
        self.image = image
        self.excerpt = excerpt
        self.date = date
        self.content = content
        self.$category.id = categoryId
    }
}

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
        .init(id: self.id!,
              title: self.title,
              slug: self.slug,
              image: self.image,
              excerpt: self.excerpt,
              date: self.date)
    }

    var getContent: GetContent {
        .init(id: self.id!,
              title: self.title,
              slug: self.slug,
              image: self.image,
              excerpt: self.excerpt,
              date: self.date,
              content: self.content)
    }
    
    private func upsert(_ content: UpsertContent) throws {
        self.title = content.title
        self.slug = content.slug
        self.image = content.image
        self.excerpt = content.excerpt
        self.date = content.date
        self.content = content.content
    }

    func create(_ content: UpsertContent) throws {
        try self.upsert(content)
    }

    func update(_ content: UpsertContent) throws {
        try self.upsert(content)
    }

    func patch(_ content: PatchContent) throws {
        self.title = content.title ?? self.title
        self.slug = content.slug ?? self.slug
        self.image = content.image ?? self.image
        self.excerpt = content.excerpt ?? self.excerpt
        self.date = content.date ?? self.date
        self.content = content.content ?? self.content
    }
}
