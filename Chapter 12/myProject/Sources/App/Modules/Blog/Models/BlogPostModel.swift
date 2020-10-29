import Vapor
import Fluent

final class BlogPostModel: Model {
    
    static let schema: String = "blog_posts"

    struct FieldKeys {
        static var title: FieldKey { "title" }
        static var slug: FieldKey { "slug" }
        static var image: FieldKey { "image" }
        static var excerpt: FieldKey { "excerpt" }
        static var date: FieldKey { "date" }
        static var content: FieldKey { "content" }
        static var categoryId: FieldKey { "category_id" }
        static var imageKey: FieldKey { "image_key" }
    }
    
    @ID() var id: UUID?
    @Field(key: FieldKeys.title) var title: String
    @Field(key: FieldKeys.slug) var slug: String
    @Field(key: FieldKeys.image) var image: String
    @Field(key: FieldKeys.excerpt) var excerpt: String
    @Field(key: FieldKeys.date) var date: Date
    @Field(key: FieldKeys.content) var content: String
    @Field(key: FieldKeys.imageKey) var imageKey: String?
    @Parent(key: FieldKeys.categoryId) var category: BlogCategoryModel

    init() { }

    init(id: UUID? = nil,
         title: String,
         slug: String,
         image: String,
         excerpt: String,
         date: Date,
         content: String,
         imageKey: String? = nil,
         categoryId: UUID)
    {
        self.id = id
        self.title = title
        self.slug = slug
        self.image = image
        self.excerpt = excerpt
        self.date = date
        self.content = content
        self.imageKey = imageKey
        $category.id = categoryId
    }
}
