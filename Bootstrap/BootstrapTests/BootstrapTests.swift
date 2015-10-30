import Quick
import Nimble
import Nimble_Snapshots

class BootstrapTests: QuickSpec {
    override func spec() {
        describe("in some context", { () -> () in
            var view: UIView!

            beforeEach {
                setNimbleTestFolder("tests")
                view = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: 44, height: 44)))
                view.backgroundColor = UIColor.blueColor()
            }

            it("has a valid snapshot") {
                expect(view).to(haveValidSnapshot())
                expect(view).to(haveValidSnapshot(named: "something custom"))
            }

            it("has a valid pretty-syntax snapshot") {
                expect(view) == snapshot("something custom")
            }

            it("has a valid pretty-snytax snapshot without specifying a name") {
                expect(view) == snapshot()
            }
          
            it("has a valid snapshot with model and OS in name") {
                expect(view).to(haveValidDeviceAgnosticSnapshot())
                expect(view).to(haveValidDeviceAgnosticSnapshot(named: "something custom with model and OS"))
            }
        })
    }
}