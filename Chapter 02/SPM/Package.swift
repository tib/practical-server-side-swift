// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "myProject",
    platforms: [
       .macOS(.v12)
    ],
    products: [
        .executable(name: "myProject", targets: ["myProject"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor", from: "4.70.0"),
    ],
    targets: [
        .executableTarget(name: "myProject", dependencies: [
            .product(name: "Vapor", package: "vapor")
        ]),
        .testTarget(name: "myProjectTests", dependencies: ["myProject"]),
    ]
)
