// swift-tools-version:6.1
import PackageDescription

let package = Package(
    name: "myProject",
    platforms: [
       .macOS(.v12),
    ],
    products: [
        .executable(name: "myProject", targets: ["myProject"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/vapor/vapor",
            from: "4.115.0"
        ),
    ],
    targets: [
        .executableTarget(name: "myProject", dependencies: [
            .product(name: "Vapor", package: "vapor")
        ]),
    ]
)
