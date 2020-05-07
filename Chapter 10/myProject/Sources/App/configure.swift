import Leaf
import Fluent
import FluentPostgresDriver
import Liquid
import LiquidLocalDriver
import Vapor

extension Environment {
    static let pgUrl = URL(string: Self.get("DB_URL")!)!
}

public func configure(_ app: Application) throws {

    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.routes.defaultMaxBodySize = "10mb"
    app.fileStorages.use(.local(publicUrl: "http://localhost:8080/",
                                publicPath: app.directory.publicDirectory,
                                workDirectory: "assets"), as: .local)

    app.views.use(.leaf)
    app.leaf.cache.isEnabled = app.environment.isRelease

    let workingDirectory = app.directory.workingDirectory
    app.leaf.configuration.rootDirectory = "/"
    app.leaf.files = ModularViewFiles(workingDirectory: workingDirectory,
                                      fileio: app.fileio)

    try app.databases.use(.postgres(url: Environment.pgUrl), as: .psql)
    app.databases.default(to: .psql)
    
    app.sessions.use(.fluent)
    app.migrations.add(SessionRecord.migration)
    app.middleware.use(app.sessions.middleware)

    let modules: [Module] = [
        UserModule(),
        FrontendModule(),
        AdminModule(),
        BlogModule(),
        UtilityModule(),
    ]

    for module in modules {
        try module.configure(app)
    }
}
