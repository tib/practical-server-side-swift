import Fluent

struct BlogMigration_v1_0_0: Migration {

    func prepare(on db: Database) -> EventLoopFuture<Void> {
        db.eventLoop.flatten([
            db.schema(BlogCategoryModel.schema)
                .id()
                .field(BlogCategoryModel.FieldKeys.title, .string, .required)
                .create(),
            db.schema(BlogPostModel.schema)
                .id()
                .field(BlogPostModel.FieldKeys.title, .string, .required)
                .field(BlogPostModel.FieldKeys.slug, .string, .required)
                .field(BlogPostModel.FieldKeys.image, .string, .required)
                .field(BlogPostModel.FieldKeys.excerpt, .string, .required)
                .field(BlogPostModel.FieldKeys.date, .datetime, .required)
                .field(BlogPostModel.FieldKeys.content, .string, .required)
                .field(BlogPostModel.FieldKeys.categoryId, .uuid)
                .foreignKey(BlogPostModel.FieldKeys.categoryId,
                            references: BlogCategoryModel.schema, .id,
                            onDelete: .cascade,
                            onUpdate: .cascade)
                .unique(on: BlogPostModel.FieldKeys.slug)
                .create(),
        ])
    }

    func revert(on db: Database) -> EventLoopFuture<Void> {
        db.eventLoop.flatten([
            db.schema(BlogCategoryModel.schema).delete(),
            db.schema(BlogPostModel.schema).delete(),
        ])
    }
}
