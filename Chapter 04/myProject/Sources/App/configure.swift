import Vapor
import Fluent
import FluentSQLiteDriver

public func configure(
    _ app: Application
) throws {

    let dbPath = app.directory.resourcesDirectory + "db.sqlite"
    app.databases.use(.sqlite(.file(dbPath)), as: .sqlite)
    
    app.middleware.use(
        FileMiddleware(
            publicDirectory: app.directory.publicDirectory
        )
    )

    app.middleware.use(ExtendPathMiddleware())

    let modules: [ModuleInterface] = [
        WebModule(),
        BlogModule(),
    ]
    for module in modules {
        try module.boot(app)
    }
    
    try app.autoMigrate().wait()
}
