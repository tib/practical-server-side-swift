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

    // ...
    
    app.sessions.use(.fluent)
    app.migrations.add(SessionRecord.migration)
    app.middleware.use(app.sessions.middleware)

    let modules: [ModuleInterface] = [
        WebModule(),
        UserModule(),
        BlogModule(),
    ]
    for module in modules {
        try module.boot(app)
    }
    
    try app.autoMigrate().wait()
}
