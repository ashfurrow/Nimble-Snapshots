import Quick
import Nimble
import Nimble_Snapshots

class BootstrapTests: QuickSpec {
    override func spec() {
        describe("in some context", { () -> () in
            it("has valid snapshot") {
                let view = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: 44, height: 44)))
                view.backgroundColor = UIColor.blueColor()
                expect(view).to(haveValidSnapshot())
                expect(view).to(haveValidSnapshot(named: "something custom"))
            }
        })
    }
}