// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "myProject",
    platforms: [
       .macOS(.v10_15)
    ],
    products: [
        .executable(name: "myProject", targets: ["myProject"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.30.0"),
    ],
    targets: [
        .target(name: "myProject", dependencies: [
            .product(name: "Vapor", package: "vapor")
        ]),
        .testTarget(name: "myProjectTests", dependencies: ["myProject"]),
    ]
)
