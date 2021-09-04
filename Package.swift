// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

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
                 .upToNextMajor(from: "7.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git",
                 .upToNextMajor(from: "9.0.0"))
    ],
    targets: [
        .target(
            name: "NimbleSnapshotsSwift",
            dependencies: ["FBSnapshotTestCase",
                           "Nimble"],
            path: "Nimble_Snapshots",
            exclude: ["XCTestObservationCenter+CurrentTestCaseTracker.h",
                      "XCTestObservationCenter+CurrentTestCaseTracker.m",
                      "DynamicType/NBSMockedApplication.h",
                      "DynamicType/NBSMockedApplication.m",
                      "Info.plist",
                      "Nimble_Snapshots.xcconfig"],
            sources: ["CurrentTestCaseTracker.swift",
                      "HaveValidSnapshot.swift",
                      "PrettySyntax.swift",
                      "DynamicSize/DynamicSizeSnapshot.swift",
                      "DynamicType/HaveValidDynamicTypeSnapshot.swift",
                      "DynamicType/PrettyDynamicTypeSyntax.swift"]
        ),
        .target(
            name: "NimbleSnapshotsObjc",
            dependencies: [
                "NimbleSnapshotsSwift"
            ],
            path: "Nimble_Snapshots",
            exclude: ["CurrentTestCaseTracker.swift",
                      "HaveValidSnapshot.swift",
                      "PrettySyntax.swift",
                      "DynamicSize/DynamicSizeSnapshot.swift",
                      "DynamicType/HaveValidDynamicTypeSnapshot.swift",
                      "DynamicType/PrettyDynamicTypeSyntax.swift",
                      "Info.plist",
                      "Nimble_Snapshots.xcconfig"],
            sources: ["XCTestObservationCenter+CurrentTestCaseTracker.h",
                      "XCTestObservationCenter+CurrentTestCaseTracker.m",
                      "DynamicType/NBSMockedApplication.h",
                      "DynamicType/NBSMockedApplication.m"]
        )
    ],
    swiftLanguageVersions: [.v4_2, .v5]
)
