import Vapor
import Fluent

protocol Module {

    static var name: String { get }
    var name: String { get }
    
    static var path: String { get }
    var path: String { get }
    
    var router: RouteCollection? { get }
    var migrations: [Migration] { get }
    var commandGroup: CommandGroup? { get }
    
    func configure(_ app: Application) throws
}

extension Module {

    static var name: String { Self.name }

    static var path: String { Self.name + "/" }
    var path: String { Self.path }

    var router: RouteCollection? { nil }
    var migrations: [Migration] { [] }
    var commandGroup: CommandGroup? { nil }
    
    func configure(_ app: Application) throws {
        for migration in migrations {
            app.migrations.add(migration)
        }
        if let router = router {
            try router.boot(routes: app.routes)
        }
        if let commandGroup = commandGroup {
            app.commands.use(commandGroup, as: name)
        }
    }
}
