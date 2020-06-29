// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "myProject",
    platforms: [
       .macOS(.v10_15)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.14.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver", from: "2.0.0"),
        .package(url: "https://github.com/vapor/jwt.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/vapor/apns", from: "1.0.0-rc"),
        .package(url: "https://github.com/binarybirds/liquid.git", from: "1.0.0"),
        .package(url: "https://github.com/binarybirds/liquid-local-driver.git", from: "1.0.0"),
        .package(url: "https://github.com/binarybirds/liquid-aws-s3-driver.git", from: "1.0.0"),
        .package(url: "https://github.com/binarybirds/view-kit.git", from: "1.1.0"),
        .package(url: "https://github.com/binarybirds/content-api.git", from: "1.0.0"),
        .package(url: "https://github.com/binarybirds/viper-kit.git", from: "1.3.0"),
        .package(url: "https://github.com/binarybirds/spec.git", from: "1.0.0"),
        .package(name: "MyProjectApi", path: "../MyProjectApi"),
    ],
    targets: [
        .target(name: "App", dependencies: [
            .product(name: "Leaf", package: "leaf"),
            .product(name: "Fluent", package: "fluent"),
            .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
            .product(name: "Liquid", package: "liquid"),
            .product(name: "LiquidAwsS3Driver", package: "liquid-aws-s3-driver"),
            .product(name: "ViewKit", package: "view-kit"),
            .product(name: "ContentApi", package: "content-api"),
            .product(name: "ViperKit", package: "viper-kit"),
            .product(name: "Vapor", package: "vapor"),
            .product(name: "APNS", package: "apns"),
            .product(name: "JWT", package: "jwt"),
            .product(name: "MyProjectApi", package: "MyProjectApi"),
        ]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "LiquidLocalDriver", package: "liquid-local-driver"),
            .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
            .product(name: "Spec", package: "spec"),
        ])
    ]
)
