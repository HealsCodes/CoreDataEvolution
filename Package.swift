// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport

import Foundation

import PackageDescription

let package = Package(
    name: "CoreDataEvolution",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CoreDataEvolution",
            targets: ["CoreDataEvolution"]
        ),
        .executable(
            name: "CoreDataEvolutionClient",
            targets: ["CoreDataEvolutionClient"]
        ),
    ],
    dependencies: [
        // .package(url: "https://github.com/sjavora/swift-syntax-xcframeworks.git", from: "600.0.0")
        .package(
            url: "https://github.com/openium/swift-syntax-xcframeworks.git",
            branch: "feat/swift-6-public-import-and-release")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .macro(
            name: "CoreDataEvolutionMacros",
            dependencies: [
                .product(name: "SwiftSyntaxWrapper", package: "swift-syntax-xcframeworks")
            ]
        ),
        .target(
            name: "CoreDataEvolution",
            dependencies: [
                "CoreDataEvolutionMacros"
            ]
        ),
        .testTarget(
            name: "CoreDataEvolutionTests",
            dependencies: [
                "CoreDataEvolution"
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .executableTarget(name: "CoreDataEvolutionClient", dependencies: ["CoreDataEvolution"]),
    ],
    swiftLanguageModes: [.version("6")]
)
