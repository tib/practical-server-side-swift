// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "MyProjectApi",
    platforms: [
       .macOS(.v11),
       .iOS(.v13),
       .tvOS(.v13),
       .watchOS(.v6),
    ],
    products: [
        .library(name: "MyProjectApi", targets: ["MyProjectApi"]),
    ],
    targets: [
        .target(name: "MyProjectApi", dependencies: []),
        .testTarget(name: "MyProjectApiTests", dependencies: ["MyProjectApi"]),
    ]
)
