// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "myProject",
    platforms: [
       .macOS(.v13),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor", from: "4.115.0"),
        .package(url: "https://github.com/apple/swift-nio", from: "2.84.0"),
    ],
    targets: [
        .executableTarget(
            name: "myProject",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
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
