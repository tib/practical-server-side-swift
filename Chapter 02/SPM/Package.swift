// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "myProject",
    platforms: [
       .macOS(.v11)
    ],
    products: [
        .executable(name: "myProject", targets: ["myProject"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor", from: "4.35.0"),
    ],
    targets: [
        .target(name: "myProject", dependencies: [
            .product(name: "Vapor", package: "vapor")
        ]),
        .testTarget(name: "myProjectTests", dependencies: ["myProject"]),
    ]
)
