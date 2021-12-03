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
        .library(
            name: "WLExts",
            targets: ["WLExts"]
        ),
        .library(
            name: "WLMedia",
            targets: ["WLMedia"]
        )
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "WeaselRoll",
            dependencies: []
        ),
        .target(
            name: "WLExts",
            dependencies: ["WeaselRoll"]
        ),
        .target(
            name: "WLMedia",
            dependencies: ["WeaselRoll"]
        ),
        .testTarget(
            name: "WeaselRollTests",
            dependencies: ["WeaselRoll", "WLExts", "WLMedia"]
        ),
    ]
)
