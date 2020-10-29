// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "myProject",
    platforms: [
       .macOS(.v10_15)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor", from: "4.34.0"),
        //.package(url: "https://github.com/vapor/leaf", from: "4.0.0"),
        .package(url: "https://github.com/tib/leaf", from: "4.0.0-rc"),
        .package(url: "https://github.com/lukaskubanek/LoremSwiftum", from: "2.2.1")
    ],
    targets: [
        .target(name: "App", dependencies: [
            .product(name: "Leaf", package: "leaf"),
            .product(name: "LoremSwiftum", package: "LoremSwiftum"),
            .product(name: "Vapor", package: "vapor"),
        ]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
