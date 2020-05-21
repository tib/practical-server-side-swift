import Fluent

struct UserMigration_v1_3_0: Migration {

    func prepare(on db: Database) -> EventLoopFuture<Void> {
        db.schema(UserDeviceModel.schema)
            .id()
            .field(UserDeviceModel.FieldKeys.token, .string, .required)
            .field(UserDeviceModel.FieldKeys.userId, .uuid)
            .foreignKey(UserDeviceModel.FieldKeys.userId,
                        references: UserModel.schema, .id,
                        onDelete: .cascade,
                        onUpdate: .cascade)
            .unique(on: UserDeviceModel.FieldKeys.token)
            .create()
    }

    func revert(on db: Database) -> EventLoopFuture<Void> {
        db.schema(UserDeviceModel.schema).delete()
    }
}
