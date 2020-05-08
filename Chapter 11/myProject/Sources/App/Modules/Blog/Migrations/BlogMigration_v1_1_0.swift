import Fluent

struct BlogMigration_v1_1_0: Migration {

    func prepare(on db: Database) -> EventLoopFuture<Void> {
        db.schema(BlogPostModel.schema)
            .field(BlogPostModel.FieldKeys.imageKey, .string)
            .update()
    }
    
    func revert(on db: Database) -> EventLoopFuture<Void> {
        db.schema(BlogPostModel.schema)
            .deleteField(BlogPostModel.FieldKeys.imageKey)
            .update()
    }
}
