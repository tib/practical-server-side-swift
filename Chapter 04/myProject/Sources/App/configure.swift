import Leaf
import Fluent
import FluentSQLiteDriver
import Vapor

public func configure(_ app: Application) throws {

    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    let detected = LeafEngine.rootDirectory ?? app.directory.viewsDirectory
    LeafEngine.rootDirectory = detected
    
    LeafEngine.sources = .singleSource(NIOLeafFiles(fileio: app.fileio,
                                                    limits: .default,
                                                    sandboxDirectory: detected,
                                                    viewDirectory: detected,
                                                    defaultExtension: "html"))

    if !app.environment.isRelease {
        app.middleware.use(DropLeafCacheMiddleware())
    }
    app.views.use(.leaf)

    let modules: [Module] = [
        FrontendModule(),
        BlogModule(),
    ]

    for module in modules {
        try module.configure(app)
    }

    try app.autoMigrate().wait()
}
