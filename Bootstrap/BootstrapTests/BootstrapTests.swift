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

            it("has a valid pretty-synxtax snapshot with emoji") {
                // Recorded with:
                // 📷(view)
                expect(view) == snapshot()
            }

            it("has a valid pretty-synxtax emoji without specifying a name") {
                expect(view) == snapshot()
            }

            it("has a valid snapshot with model and OS in name") {
                expect(view).to(haveValidDeviceAgnosticSnapshot())
                expect(view).to(haveValidDeviceAgnosticSnapshot(named: "something custom with model and OS"))
            }

            // The easiest way to test this is a to have a view that is changed by UIAppearance
            // https://github.com/facebook/ios-snapshot-test-case/issues/91
            // If this is not using drawRect it will fail

            it("has a valid snapshot when draw rect is turned on ") {
                UIButton.appearance().tintColor = UIColor.redColor()
                let imageView = UIButton(type: .ContactAdd)

                // expect(imageView).to( recordSnapshot(usesDrawRect: true) )
                expect(imageView).to( haveValidSnapshot(usesDrawRect: true) )
            }
        })
    }
}