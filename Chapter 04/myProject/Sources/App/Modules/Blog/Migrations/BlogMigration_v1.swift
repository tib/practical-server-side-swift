import Fluent

struct BlogMigration_v1: Migration {

    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(BlogCategoryModel.schema)
                .id()
                .field(BlogCategoryModel.FieldKeys.title, .string, .required)
                .create(),
            database.schema(BlogPostModel.schema)
                .id()
                .field(BlogPostModel.FieldKeys.title, .string, .required)
                .field(BlogPostModel.FieldKeys.slug, .string, .required)
                .field(BlogPostModel.FieldKeys.imageKey, .string, .required)
                .field(BlogPostModel.FieldKeys.excerpt, .data, .required)
                .field(BlogPostModel.FieldKeys.date, .datetime, .required)
                .field(BlogPostModel.FieldKeys.content, .data, .required)
                .field(BlogPostModel.FieldKeys.categoryId, .uuid)
                .foreignKey(BlogPostModel.FieldKeys.categoryId,
                            references: BlogCategoryModel.schema, .id,
                            onDelete: DatabaseSchema.ForeignKeyAction.setNull,
                            onUpdate: .cascade)
                .unique(on: BlogPostModel.FieldKeys.slug)
                .create(),
        ])
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(BlogCategoryModel.schema).delete(),
            database.schema(BlogPostModel.schema).delete(),
        ])
    }
}
