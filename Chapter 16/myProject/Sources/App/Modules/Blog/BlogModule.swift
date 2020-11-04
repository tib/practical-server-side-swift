import Vapor
import Fluent

struct BlogModule: ViperModule {
    
    static var name: String = "blog"

    var router: ViperRouter? { BlogRouter() }

    var migrations: [Migration] {
        [
            BlogMigration_v1_0_0(),
            BlogMigration_v1_1_0(),
            BlogMigrationSeed(),
        ]
    }
}
