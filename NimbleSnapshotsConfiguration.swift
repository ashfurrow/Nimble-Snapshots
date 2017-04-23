import Quick
import XCTest

class FBSnapshotTestConfiguration: QuickConfiguration {

    override class func configure(_ configuration: Configuration) {
        configuration.beforeEach { exampleMetadata in
            FBSnapshotTest.sharedInstance.currentExampleMetadata = exampleMetadata
        }

        configuration.afterEach { (_: ExampleMetadata) in
            FBSnapshotTest.sharedInstance.currentExampleMetadata = nil
        }
    }
}

/// Helper class providing access to the currently executing XCTestCase instance, if any
@objc public final class CurrentTestCaseTracker: NSObject, XCTestObservation {
    @objc public static let shared = CurrentTestCaseTracker()

    private(set) var currentTestCase: XCTestCase?

    @objc public func testCaseWillStart(_ testCase: XCTestCase) {
        currentTestCase = testCase
    }

    @objc public func testCaseDidFinish(_ testCase: XCTestCase) {
        currentTestCase = nil
    }
}
