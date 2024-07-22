// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ImitatorAI",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ImitatorAI",
            targets: ["ImitatorAI"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/swiftcoderjoe/swiftanthropic.git", from: "1.0.0"),
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.1.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ImitatorAI",
            dependencies: [
                .product(name: "SwiftAnthropic", package: "SwiftAnthropic")
            ]
        ),
        .testTarget(
            name: "ImitatorAITests",
            dependencies: ["ImitatorAI"])
    ]
)
