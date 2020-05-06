import Leaf
import Fluent
import FluentSQLiteDriver
import Vapor

public func configure(_ app: Application) throws {

    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.views.use(.leaf)
    app.leaf.cache.isEnabled = app.environment.isRelease

    let workingDirectory = app.directory.workingDirectory
    app.leaf.configuration.rootDirectory = "/"
    app.leaf.files = ModularViewFiles(workingDirectory: workingDirectory,
                                      fileio: app.fileio)

    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
    
    app.sessions.use(.fluent)
    app.migrations.add(SessionRecord.migration)
    app.middleware.use(SessionsMiddleware(session: app.sessions.driver))

    let modules: [Module] = [
        FrontendModule(),
        BlogModule(),
        UserModule(),
    ]

    for module in modules {
        try module.configure(app)
    }
}
