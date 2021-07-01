import Vapor
import Tau

public func configure(_ app: Application) throws {

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

    /// setup module routes
    let routers: [RouteCollection] = [
        FrontendRouter(),
        BlogRouter(),
    ]
    for router in routers {
        try router.boot(routes: app.routes)
    }
}

