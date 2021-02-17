// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeaselRoll",
    platforms: [.iOS(.v10)],
    products: [
        .library(
            name: "WeaselRoll",
            targets: ["WeaselRoll"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "WeaselRoll",
            dependencies: []
        ),
        .testTarget(
            name: "WeaselRollTests",
            dependencies: ["WeaselRoll"]
        ),
    ]
)
