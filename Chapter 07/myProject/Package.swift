// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "myProject",
    platforms: [
       .macOS(.v10_15)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor", from: "4.45.5"),
        .package(url: "https://github.com/vapor/fluent", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent-sqlite-driver", from: "4.0.0"),
        .package(url: "https://github.com/binarybirds/tau", from: "1.0.0"),
        .package(url: "https://github.com/lukaskubanek/LoremSwiftum", from: "2.2.1"),
        .package(url: "https://github.com/binarybirds/liquid", from: "1.1.0"),
        .package(url: "https://github.com/binarybirds/liquid-local-driver", from: "1.1.0"),
    ],
    targets: [
        .target(name: "App", dependencies: [
            .product(name: "LoremSwiftum", package: "LoremSwiftum"),
            .product(name: "Tau", package: "tau"),
            .product(name: "Fluent", package: "fluent"),
            .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
            .product(name: "Liquid", package: "liquid"),
            .product(name: "LiquidLocalDriver", package: "liquid-local-driver"),
            .product(name: "Vapor", package: "vapor"),
        ], exclude: [
            "Modules/Blog/Templates",
            "Modules/Frontend/Templates",
            "Modules/User/Templates",
            "Modules/Admin/Templates",
            "Modules/Common/Templates",
        ]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
