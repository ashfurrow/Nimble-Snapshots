// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// swiftlint:disable:next prefixed_toplevel_constant
let package = Package(
    name: "Nimble-Snapshots",
    platforms: [.iOS(.v13), .tvOS(.v13)],
    products: [
        .library(
            name: "Nimble-Snapshots",
            targets: ["NimbleSnapshotsObjc"])
    ],
    dependencies: [
        .package(url: "https://github.com/uber/ios-snapshot-test-case.git",
                 .upToNextMajor(from: "8.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git",
                 .upToNextMajor(from: "12.3.0"))
    ],
    targets: [
        .target(
            name: "Nimble-Snapshots",
            dependencies: [
                .product(name:"iOSSnapshotTestCase", package: "ios-snapshot-test-case"),
                .product(name: "Nimble", package: "Nimble")
            ],
            path: "Nimble_Snapshots",
            exclude: ["XCTestObservationCenter+CurrentTestCaseTracker.h",
                      "XCTestObservationCenter+CurrentTestCaseTracker.m",
                      "Info.plist",
                      "Nimble_Snapshots.xcconfig"],
            sources: ["CurrentTestCaseTracker.swift",
                      "HaveValidSnapshot.swift",
                      "PrettySyntax.swift",
                      "DynamicSize",
                      "DynamicType"]
        ),
        .target(
            name: "NimbleSnapshotsObjc",
            dependencies: [
                "Nimble-Snapshots"
            ],
            path: "Nimble_Snapshots",
            exclude: ["CurrentTestCaseTracker.swift",
                      "HaveValidSnapshot.swift",
                      "PrettySyntax.swift",
                      "DynamicSize",
                      "DynamicType",
                      "Info.plist",
                      "Nimble_Snapshots.xcconfig"],
            sources: ["XCTestObservationCenter+CurrentTestCaseTracker.h",
                      "XCTestObservationCenter+CurrentTestCaseTracker.m"],
            publicHeadersPath: "."
        )
    ],
    swiftLanguageVersions: [.v5]
)
