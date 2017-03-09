import Quick
import Nimble
@testable import Nimble_Snapshots
import XCTest

class WithoutQuickTests: XCTestCase {

    override func setUp() {
        FBSnapshotTest.sharedInstance.currentExampleMetadata = nil
    }

    func testItWorksWithXCTest() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = .orange

        expect(view).to(haveValidSnapshot())
    }
}
