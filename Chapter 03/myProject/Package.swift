// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "myProject",
    platforms: [
       .macOS(.v12)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor", from: "4.54.0"),
        .package(url: "https://github.com/binarybirds/swift-html", from: "1.1.0"),
        .package(url: "https://github.com/lukaskubanek/LoremSwiftum", from: "2.2.1"),
    ],
    targets: [
        .target(name: "App", dependencies: [
            .product(name: "LoremSwiftum", package: "LoremSwiftum"),
            .product(name: "SwiftHtml", package: "swift-html"),
            .product(name: "SwiftSvg", package: "swift-html"),
            .product(name: "Vapor", package: "vapor"),
        ]),
        .executableTarget(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
