import Leaf
import Fluent
import FluentPostgresDriver
import Liquid
import LiquidLocalDriver
//import LiquidAwsS3Driver
import Vapor

extension Environment {
    static let pgUrl = URL(string: Self.get("DB_URL")!)!
    static let appUrl = URL(string: Self.get("APP_URL")!)!
//    static let awsKey = Self.get("AWS_KEY")!
//    static let awsSecret = Self.get("AWS_SECRET")!

}

public func configure(_ app: Application) throws {

    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.routes.defaultMaxBodySize = "10mb"
    app.fileStorages.use(.local(publicUrl: Environment.appUrl.absoluteString,
                                publicPath: app.directory.publicDirectory,
                                workDirectory: "assets"), as: .local)

//    app.fileStorages.use(.awsS3(key: Environment.awsKey,
//                                    secret: Environment.awsSecret,
//                                    bucket: "vaportestbucket",
//                                    region: .uswest1), as: .awsS3)


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
