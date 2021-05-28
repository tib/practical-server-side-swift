import Vapor
import Tau
import Fluent
import FluentSQLiteDriver

public func configure(_ app: Application) throws {

    let dbPath = app.directory.resourcesDirectory + "db.sqlite"
    app.databases.use(.sqlite(.file(dbPath)), as: .sqlite)


    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.middleware.use(ExtendPathMiddleware())

    if !app.environment.isRelease {
        TemplateRenderer.Option.caching = .bypass
    }
    app.views.use(.tau)

    let modules: [Module] = [
        FrontendModule(),
        BlogModule(),
    ]
    
    for module in modules {
        try module.boot(app)
    }
    
    try app.autoMigrate().wait()
}
