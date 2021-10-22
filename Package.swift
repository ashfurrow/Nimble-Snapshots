// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// swiftlint:disable:next prefixed_toplevel_constant
let package = Package(
    name: "Nimble-Snapshots",
    platforms: [.iOS(.v10), .tvOS(.v10)],
    products: [
        .library(
            name: "Nimble-Snapshots",
            targets: ["NimbleSnapshotsObjc"])
    ],
    dependencies: [
        .package(name: "FBSnapshotTestCase",
                 url: "https://github.com/uber/ios-snapshot-test-case.git",
                 .upToNextMajor(from: "8.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git",
                 .upToNextMajor(from: "9.0.0"))
    ],
    targets: [
        .target(
            name: "Nimble-Snapshots",
            dependencies: ["FBSnapshotTestCase",
                           "Nimble"],
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
                      "XCTestObservationCenter+CurrentTestCaseTracker.m"]
        )
    ],
    swiftLanguageVersions: [.v4_2, .v5]
)
