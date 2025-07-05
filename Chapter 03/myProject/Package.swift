// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "myProject",
    platforms: [
       .macOS(.v13),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor", from: "4.115.0"),
        .package(url: "https://github.com/binarybirds/swift-html", from: "1.7.0"),
    ],
    targets: [
        .executableTarget(
            name: "myProject",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "SwiftHtml", package: "swift-html"),
                .product(name: "SwiftSvg", package: "swift-html"),
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "myProjectTests",
            dependencies: [
                .target(name: "myProject"),
                .product(name: "VaporTesting", package: "vapor"),
            ],
            swiftSettings: swiftSettings
        )
    ]
)

var swiftSettings: [SwiftSetting] { [
    .enableUpcomingFeature("ExistentialAny"),
] }
