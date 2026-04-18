// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "SPMTestHarness",
    platforms: [.iOS(.v13)],
    dependencies: [
        .package(path: "..")
    ],
    targets: [
        .target(
            name: "SPMTestHarness",
            dependencies: [
                .product(name: "Nimble-Snapshots", package: "Nimble-Snapshots")
            ]
        )
    ]
)
