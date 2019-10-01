import XCTest
@testable import Nimble_Snapshots

final class Nimble_SnapshotsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Nimble_Snapshots().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
