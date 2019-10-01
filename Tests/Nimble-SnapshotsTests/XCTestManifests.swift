import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Nimble_SnapshotsTests.allTests),
    ]
}
#endif
