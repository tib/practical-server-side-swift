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
        .package(url: "https://github.com/binarybirds/liquid.git", from: "1.0.0"),
        .package(url: "https://github.com/binarybirds/liquid-local-driver.git", from: "1.0.0"),
        //.package(url: "https://github.com/binarybirds/liquid-aws-s3-driver.git", from: "1.0.0"),
        .package(url: "https://github.com/binarybirds/view-kit.git", from: "1.1.0"),
        .package(url: "https://github.com/binarybirds/content-api.git", from: "1.0.0"),
        .package(url: "https://github.com/binarybirds/viper-kit.git", from: "1.3.0"),
    ],
    targets: [
        .target(name: "App", dependencies: [
            .product(name: "Leaf", package: "leaf"),
            .product(name: "Fluent", package: "fluent"),
            .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
            .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
            .product(name: "Liquid", package: "liquid"),
            .product(name: "LiquidLocalDriver", package: "liquid-local-driver"),
            //.product(name: "LiquidAwsS3Driver", package: "liquid-aws-s3-driver"),
            .product(name: "ViewKit", package: "view-kit"),
            .product(name: "ContentApi", package: "content-api"),
            .product(name: "ViperKit", package: "viper-kit"),
            .product(name: "Vapor", package: "vapor"),
        ]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
