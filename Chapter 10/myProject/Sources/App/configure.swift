import Vapor
import Leaf
import Fluent
import FluentSQLiteDriver
import FluentPostgresDriver
import Liquid
import LiquidLocalDriver
//import LiquidAwsS3Driver
@_exported import ViewKit
@_exported import ContentApi
@_exported import ViperKit

extension Environment {
//    static let pgUrl = URL(string: Self.get("DB_URL")!)!
    static let appUrl = URL(string: Self.get("APP_URL")!)!
//    static let awsKey = Self.get("AWS_KEY")!
//    static let awsSecret = Self.get("AWS_SECRET")!
}

public func configure(_ app: Application) throws {

    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
    //try app.databases.use(.postgres(url: Environment.pgUrl), as: .psql)
    
    app.routes.defaultMaxBodySize = "10mb"
    app.fileStorages.use(.local(publicUrl: "http://localhost:8080",
                                publicPath: app.directory.publicDirectory,
                                workDirectory: "assets"), as: .local)
    
//    app.fileStorages.use(.awsS3(key: Environment.awsKey,
//                                secret: Environment.awsSecret,
//                                bucket: "vaportestbucket",
//                                region: .uswest1), as: .awsS3)

    app.sessions.use(.fluent)
    app.migrations.add(SessionRecord.migration)
    app.middleware.use(app.sessions.middleware)

    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    if !app.environment.isRelease {
        app.middleware.use(DropLeafCacheMiddleware())
    }

    LeafEngine.entities.use(RequestSetQueryFunction(), asFunction: "Request")

    try LeafEngine.useViperViews(viewsDirectory: app.directory.viewsDirectory,
                                 workingDirectory: app.directory.workingDirectory,
                                 fileExtension: "html",
                                 fileio: app.fileio)
    app.views.use(.leaf)

    let modules: [ViperModule] = [
        UserModule(),
        FrontendModule(),
        AdminModule(),
        BlogModule(),
        UtilityModule(),
    ]

    try app.viper.use(modules)

    try app.autoMigrate().wait()
}
