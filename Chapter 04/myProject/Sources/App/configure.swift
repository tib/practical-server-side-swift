import Vapor
import Tau
import Fluent
import FluentSQLiteDriver

public func configure(_ app: Application) throws {

    /// setup Fluent with a SQLite database under the Resources directory
    let dbPath = app.directory.resourcesDirectory + "db.sqlite"
    app.databases.use(.sqlite(.file(dbPath)), as: .sqlite)
    
    /// use the Public directory to serve public files
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    /// extend paths to always contain a trailing slash
    app.middleware.use(ExtendPathMiddleware())

    /// setup custom template location
    let templatesFolderName = "Templates"
    app.directory.viewsDirectory = app.directory.resourcesDirectory + templatesFolderName + "/"
    let detected = TemplateEngine.rootDirectory ?? app.directory.viewsDirectory
    TemplateEngine.rootDirectory = detected
    
    TemplateEngine.sources = .singleSource(FileSource(fileio: app.fileio,
                                                      limits: .default,
                                                      sandboxDirectory: detected,
                                                      viewDirectory: detected,
                                                      defaultExtension: "html"))
    /// disable template cache
    if !app.environment.isRelease {
        TemplateRenderer.Option.caching = .bypass
    }
    
    /// use Tau as template engine
    app.views.use(.tau)

    /// setup modules
    let modules: [ModuleInterface] = [
        FrontendModule(),
        BlogModule(),
    ]
    for module in modules {
        try module.boot(app)
    }
    
    /// use automatic database migration
    try app.autoMigrate().wait()
}

