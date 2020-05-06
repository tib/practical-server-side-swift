import Vapor
import Fluent

struct BlogModule: Module {
    
    static var name: String = "blog"
    
    var router: RouteCollection? { BlogRouter() }

    var migrations: [Migration] {
        [
            BlogMigration_v1_0_0(),
            BlogMigration_v1_1_0(),
        ]
    }
}
