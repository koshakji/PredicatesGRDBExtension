// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PredicatesGRDBExtension",
    platforms: [.macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PredicatesGRDBExtension",
            targets: ["PredicatesGRDBExtension"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/koshakji/Predicates.swift", branch: "main"),
        .package(url: "https://github.com/groue/GRDB.swift.git", .upToNextMinor(from: "6.5.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PredicatesGRDBExtension",
            dependencies: [
                .product(name: "GRDB", package: "GRDB.swift"),
                .product(name: "Predicates", package: "Predicates.swift")
            ]),
        .testTarget(
            name: "PredicatesGRDBExtensionTests",
            dependencies: [
                "PredicatesGRDBExtension"
            ]),
    ]
)
