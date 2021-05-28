import Vapor
import Tau

public func configure(_ app: Application) throws {

    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.middleware.use(ExtendPathMiddleware())
    
//    let detected = TemplateEngine.rootDirectory ?? app.directory.viewsDirectory
//    TemplateEngine.rootDirectory = detected
//
//    TemplateEngine.sources = .singleSource(FileSource(fileio: app.fileio,
//                                                      limits: .default,
//                                                      sandboxDirectory: detected,
//                                                      viewDirectory: detected,
//                                                      defaultExtension: "html"))

    if !app.environment.isRelease {
        TemplateRenderer.Option.caching = .bypass
    }
    app.views.use(.tau)

    let routers: [RouteCollection] = [
        FrontendRouter(),
        BlogRouter(),
    ]
    
    for router in routers {
        try router.boot(routes: app.routes)
    }
}
