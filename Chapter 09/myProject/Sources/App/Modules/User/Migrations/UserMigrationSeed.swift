import Vapor
import Fluent

struct UserMigrationSeed: Migration {

    func prepare(on db: Database) -> EventLoopFuture<Void> {
        [
            UserModel(email: "root@localhost.com", password: try! Bcrypt.hash("ChangeMe1"))
        ].create(on: db)
    }

    func revert(on db: Database) -> EventLoopFuture<Void> {
        UserModel.query(on: db).delete()
    }
}
