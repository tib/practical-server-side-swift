import Leaf
import Fluent
import FluentSQLiteDriver
import Vapor

public func configure(_ app: Application) throws {

    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    
    app.views.use(.leaf)
    app.leaf.cache.isEnabled = app.environment.isRelease
    let source = ModularViewFiles(rootDirectory: app.directory.workingDirectory,
                                  modulesDirectory: "Sources/App/Modules",
                                  resourcesDirectory: "Resources",
                                  viewsFolderName: "Views",
                                  fileExtension: "leaf",
                                  fileio: app.fileio)
    app.leaf.sources = .singleSource(source)

    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

    app.sessions.use(.fluent)
    app.migrations.add(SessionRecord.migration)
    app.middleware.use(app.sessions.middleware)

    let modules: [Module] = [
        FrontendModule(),
        BlogModule(),
        UserModule(),
    ]

    for module in modules {
        try module.configure(app)
    }
}
