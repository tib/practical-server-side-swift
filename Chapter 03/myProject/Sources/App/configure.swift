import Vapor
import Leaf

public func configure(_ app: Application) throws {

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
    
    let routers: [RouteCollection] = [
        FrontendRouter(),
        BlogRouter(),
    ]
    for router in routers {
        try router.boot(routes: app.routes)
    }
}

