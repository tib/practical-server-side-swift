import Vapor
import Tau
import Fluent
import FluentSQLiteDriver

public func configure(_ app: Application) throws {

    let dbPath = app.directory.resourcesDirectory + "db.sqlite"
    app.databases.use(.sqlite(.file(dbPath)), as: .sqlite)

    app.sessions.use(.fluent)
    app.migrations.add(SessionRecord.migration)
    app.middleware.use(app.sessions.middleware)

    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.middleware.use(ExtendPathMiddleware())

    //...
    
    /// replace views with templates
    let templatesFolderName = "Templates"
    app.directory.viewsDirectory = app.directory.resourcesDirectory + templatesFolderName + "/"

    let detected = TemplateEngine.rootDirectory ?? app.directory.viewsDirectory
    TemplateEngine.rootDirectory = detected
    
    let defaultSource = FileSource(fileio: app.fileio,
                                   limits: .default,
                                   sandboxDirectory: detected,
                                   viewDirectory: detected,
                                   defaultExtension: "html")
    
    let modulesSource = ModuleTemplateSource(rootDirectory: app.directory.workingDirectory,
                                             modulesLocation: "Sources/App/Modules",
                                             folderName: templatesFolderName,
                                             fileExtension: "html",
                                             fileio: app.fileio)
    
    let multipleSources = TemplateSources()
    try multipleSources.register(using: defaultSource)
    try multipleSources.register(source: "modules", using: modulesSource)
    TemplateEngine.sources = multipleSources
    
    
    if !app.environment.isRelease {
        TemplateRenderer.Option.caching = .bypass
    }
    app.views.use(.tau)

    //...
    
    let modules: [Module] = [
        FrontendModule(),
        BlogModule(),
        UserModule(),
    ]
    
    for module in modules {
        try module.boot(app)
    }
    
    try app.autoMigrate().wait()
}
