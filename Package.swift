// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SyncHTTP",
    products: [
        .library(name: "SyncHTTP", targets: ["SyncHTTP"]),
    ],
    targets: [
        .target(name: "SyncHTTP", dependencies: []),
        .testTarget(name: "SyncHTTPTests", dependencies: ["SyncHTTP"]),
    ]
)
