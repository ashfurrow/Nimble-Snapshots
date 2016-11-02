import Quick
import Nimble
import Nimble_Snapshots

class BootstrapSwift3Tests: QuickSpec {
    override func spec() {
        describe("with Swift 3") {
            var view: UIView!

            beforeEach {
                setNimbleTolerance(0)
                setNimbleTestFolder("tests")
                view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 44, height: 44)))
                view.backgroundColor = .blue
            }

            it("has a valid snapshot") {
                expect(view).to(haveValidSnapshot())
            }
        }
    }
}
