import Vapor
import SwiftHtml
import SwiftSgml

public func configure(_ app: Application) throws {
    
    /// use the Public directory to serve public files
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    /// extend paths to always contain a trailing slash
    app.middleware.use(ExtendPathMiddleware())
    
    /// setup module routes
    let routers: [RouteCollection] = [
        WebRouter(),
        BlogRouter(),
    ]
    for router in routers {
        try router.boot(routes: app.routes)
    }
}

