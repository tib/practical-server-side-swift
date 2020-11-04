import Fluent

struct UserMigration_v1_2_0: Migration {

    func prepare(on db: Database) -> EventLoopFuture<Void> {
        db.schema(UserModel.schema)
            .field(UserModel.FieldKeys.appleId, .string)
            /// NOTE: not working for SQLite
            //.unique(on: UserModel.FieldKeys.appleId)
            .update()
    }

    func revert(on db: Database) -> EventLoopFuture<Void> {
        db.schema(UserModel.schema)
            .deleteField(UserModel.FieldKeys.appleId)
            .update()
    }
}
