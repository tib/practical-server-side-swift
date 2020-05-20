import Vapor
import Fluent

struct UserMigration_v1_0_0: Migration {

    func prepare(on db: Database) -> EventLoopFuture<Void> {
        db.eventLoop.flatten([
            db.schema(UserModel.schema)
                .id()
                .field(UserModel.FieldKeys.email, .string, .required)
                .field(UserModel.FieldKeys.password, .string, .required)
                .unique(on: UserModel.FieldKeys.email)
                .create(),
        ])
    }

    func revert(on db: Database) -> EventLoopFuture<Void> {
        db.eventLoop.flatten([
            db.schema(UserModel.schema).delete(),
        ])
    }
}
