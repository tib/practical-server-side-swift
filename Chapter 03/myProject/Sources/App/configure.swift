import Vapor

public func configure(
    _ app: Application
) throws {

    app.middleware.use(
        FileMiddleware(
            publicDirectory: app.directory.publicDirectory
        )
    )

    app.middleware.use(ExtendPathMiddleware())

    let routers: [RouteCollection] = [
        WebRouter(),
        BlogRouter(),
    ]
    for router in routers {
        try router.boot(routes: app.routes)
    }
}
