import Vapor
import Leaf
import LeafFoundation
import Fluent
import FluentPostgresDriver
import Liquid
import LiquidAwsS3Driver
import JWT
import APNS
@_exported import ContentApi
@_exported import ViewKit
@_exported import ViperKit

protocol ViperAdminViewController: AdminViewController where Model: ViperModel  {
    associatedtype Module: ViperModule
}

extension ViperAdminViewController {

    var listView: String { "\(Module.name.capitalized)/Admin/\(Model.name.capitalized)/List" }
    var editView: String { "\(Module.name.capitalized)/Admin/\(Model.name.capitalized)/Edit" }
}

public func configure(_ app: Application) throws {

    app.jwt.apple.applicationIdentifier = Environment.SignInWithApple.id
    let signer = try JWTSigner.es256(key: .private(pem: Environment.SignInWithApple.privateKey.bytes))
    app.jwt.signers.use(signer, kid: .apple, isDefault: false)

    app.apns.configuration = try .init(
            authenticationMethod: .jwt(
                key: .private(pem: Data(Environment.Apns.privateKey.utf8)),
                keyIdentifier: .init(string: Environment.Apns.keyId),
                teamIdentifier: Environment.Apns.teamId
            ),
        topic: Environment.Apns.topic,
            environment: .sandbox
        )

    let configuration = PostgresConfiguration(hostname: Environment.Postgres.host,
                                              port: Environment.Postgres.port,
                                              username: Environment.Postgres.user,
                                              password: Environment.Postgres.pass,
                                              database: Environment.Postgres.database)
    app.databases.use(.postgres(configuration: configuration), as: .psql)

    app.routes.defaultMaxBodySize = "10mb"

    app.fileStorages.use(.awsS3(region: .init(rawValue: Environment.Aws.region),
                                bucket: .init(stringLiteral: Environment.Aws.bucket)), as: .awsS3)

    app.sessions.use(.fluent)
    app.migrations.add(SessionRecord.migration)
    app.middleware.use(app.sessions.middleware)

    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.middleware.use(ExtendPathMiddleware())

    let detected = LeafEngine.rootDirectory ?? app.directory.viewsDirectory
    LeafEngine.rootDirectory = detected
    LeafEngine.useLeafFoundation()

    if !app.environment.isRelease {
        LeafRenderer.Option.caching = .bypass
    }

    try LeafEngine.useViperViews(viewsDirectory: app.directory.viewsDirectory,
                                 workingDirectory: app.directory.workingDirectory,
                                 modulesLocation: "Sources/App/Modules",
                                 moduleViewsLocation: "Views",
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

    for module in modules {
        try module.configure(app)
    }

    try app.autoMigrate().wait()
}
