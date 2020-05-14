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
