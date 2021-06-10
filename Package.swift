// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Thespian",
    platforms: [.macOS("12")],
    products: [
    ],
    dependencies: [
    ],
    targets: [
        .testTarget(
            name: "ThespianTests",
            dependencies: []),
    ]
)
