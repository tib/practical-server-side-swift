import Vapor
import Fluent

struct UserMigrationSeed: Migration {

    private func users() -> [UserModel] {
        [
            UserModel(email: "mail.tib@gmail.com",
                      password: try! Bcrypt.hash("ChangeMe1"))
        ]
    }

    func prepare(on db: Database) -> EventLoopFuture<Void> {
        self.users().create(on: db)
    }

    func revert(on db: Database) -> EventLoopFuture<Void> {
        UserModel.query(on: db).delete()
    }
}
