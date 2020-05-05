import Leaf
import Fluent
import FluentSQLiteDriver
import Vapor

public func configure(_ app: Application) throws {

    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.views.use(.leaf)
    app.leaf.cache.isEnabled = app.environment.isRelease
    
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

    let modules: [Module] = [
        FrontendModule(),
        BlogModule(),
    ]

    for module in modules {
        try module.configure(app)
    }
}
