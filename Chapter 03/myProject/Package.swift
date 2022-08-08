// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "myProject",
    platforms: [
       .macOS(.v12)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor", from: "4.65.0"),
        .package(url: "https://github.com/binarybirds/swift-html", from: "1.6.0"),
    ],
    targets: [
        .target(name: "App", dependencies: [
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
