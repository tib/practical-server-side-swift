import Leaf
import Fluent
import FluentPostgresDriver
import Liquid
import LiquidAwsS3Driver
import ViewKit
import ViperKit
import Vapor

extension Environment {
    static let dbHost = Self.get("DB_HOST")!
    static let dbUser = Self.get("DB_USER")!
    static let dbPass = Self.get("DB_PASS")!
    static let dbName = Self.get("DB_NAME")!

    static let fsName = Self.get("FS_NAME")!
    static let fsRegion = Self.get("FS_REGION")!

    static let awsKey = Self.get("AWS_KEY")!
    static let awsSecret = Self.get("AWS_SECRET")!
}

public func configure(_ app: Application) throws {

    let configuration = PostgresConfiguration(
        hostname: Environment.dbHost,
        port: 5432,
        username: Environment.dbUser,
        password: Environment.dbPass,
        database: Environment.dbName
    )
    app.databases.use(.postgres(configuration: configuration), as: .psql)

    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.routes.defaultMaxBodySize = "10mb"

    app.fileStorages.use(.awsS3(key: Environment.awsKey,
                                    secret: Environment.awsSecret,
                                    bucket: Environment.fsName,
                                    region: .init(rawValue: Environment.fsRegion)), as: .awsS3)

    app.views.use(.leaf)
    if !app.environment.isRelease {
        app.leaf.cache.isEnabled = false
        app.leaf.useViperViews()
    }

    app.sessions.use(.fluent)
    app.migrations.add(SessionRecord.migration)
    app.middleware.use(app.sessions.middleware)

    let modules: [ViperModule] = [
        UserModule(),
        FrontendModule(),
        AdminModule(),
        BlogModule(),
    ]

    try app.viper.use(modules)
    try app.autoMigrate().wait()
}

protocol ViperAdminViewController: AdminViewController where Model: ViperModel  {
    associatedtype Module: ViperModule
}

extension ViperAdminViewController {

    var listView: String { "\(Module.name.capitalized)/Admin/\(Model.name.capitalized)/List" }
    var editView: String { "\(Module.name.capitalized)/Admin/\(Model.name.capitalized)/Edit" }
}

extension Fluent.Model where IDValue == UUID {
    var viewIdentifier: String { self.id!.uuidString }
}
