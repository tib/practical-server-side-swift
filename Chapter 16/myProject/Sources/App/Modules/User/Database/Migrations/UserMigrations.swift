import Vapor
import Fluent

enum UserMigrations {
    
    struct v1: AsyncMigration {
        
        func prepare(on db: Database) async throws {
            try await db.schema(UserAccountModel.schema)
                .id()
                .field(UserAccountModel.FieldKeys.v1.email, .string, .required)
                .field(UserAccountModel.FieldKeys.v1.password, .string, .required)
                .unique(on: UserAccountModel.FieldKeys.v1.email)
                .create()
            
            try await db.schema(UserTokenModel.schema)
                .id()
                .field(UserTokenModel.FieldKeys.v1.value, .string, .required)
                .field(UserTokenModel.FieldKeys.v1.userId, .uuid, .required)
                .foreignKey(
                    UserTokenModel.FieldKeys.v1.userId,
                    references: UserAccountModel.schema, .id
                )
                .unique(on: UserTokenModel.FieldKeys.v1.value)
                .create()
        }

        func revert(on db: Database) async throws  {
            try await db.schema(UserTokenModel.schema).delete()
            try await db.schema(UserAccountModel.schema).delete()
        }
    }
    
    struct seed: AsyncMigration {
        
        func prepare(on db: Database) async throws {
            let email = "root@localhost.com"
            let password = "ChangeMe1"
            let user = UserAccountModel(
                email: email,
                password: try Bcrypt.hash(password)
            )
            try await user.create(on: db)
        }

        func revert(on db: Database) async throws {
            try await UserAccountModel.query(on: db).delete()
        }
    }
}
