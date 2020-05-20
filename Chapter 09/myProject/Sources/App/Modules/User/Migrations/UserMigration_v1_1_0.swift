import Fluent

struct UserMigration_v1_1_0: Migration {

    func prepare(on db: Database) -> EventLoopFuture<Void> {
        db.schema(UserTokenModel.schema)
            .id()
            .field(UserTokenModel.FieldKeys.value, .string, .required)
            .field(UserTokenModel.FieldKeys.userId, .uuid, .required)
            .foreignKey(UserTokenModel.FieldKeys.userId,
                        references: UserModel.schema, .id)
            .unique(on: UserTokenModel.FieldKeys.value)
            .create()
    }

    func revert(on db: Database) -> EventLoopFuture<Void> {
        db.schema(UserTokenModel.schema).delete()
    }
}
