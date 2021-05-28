import Vapor
import Fluent

struct UserMigration_v1: Migration {

    func prepare(on db: Database) -> EventLoopFuture<Void> {
        db.schema(UserModel.schema)
            .id()
            .field(UserModel.FieldKeys.email, .string, .required)
            .field(UserModel.FieldKeys.password, .string, .required)
            .unique(on: UserModel.FieldKeys.email)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(UserModel.schema).delete()
    }
}
