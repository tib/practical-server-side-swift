import Leaf
import Fluent
import FluentPostgresDriver
import Liquid
import LiquidAwsS3Driver
import ViewKit
import ViperKit
import Vapor
import JWT
import APNS

public func configure(_ app: Application) throws {

    app.apns.configuration = try .init(
        authenticationMethod: .jwt(
            key: .private(pem: Data(Environment.apnsKey.utf8)),
            keyIdentifier: .init(string: Environment.apnsKeyId),
            teamIdentifier: Environment.apnsTeamId
        ),
        topic: Environment.apnsTopic,
        environment: .sandbox
    )

    let configuration = PostgresConfiguration(
        hostname: Environment.dbHost,
        port: 5432,
        username: Environment.dbUser,
        password: Environment.dbPass,
        database: Environment.dbName
    )
    app.databases.use(.postgres(configuration: configuration), as: .psql)

    app.jwt.apple.applicationIdentifier = Environment.siwaId
    let signer = try JWTSigner.es256(key: .private(pem: Environment.siwaKey.bytes))
    app.jwt.signers.use(signer, kid: .apple, isDefault: false)

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
