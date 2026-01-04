import Nimble
import Nimble_Snapshots
import Quick
import UIKit

@MainActor
final class BootstrapTests: QuickSpec {

    override func spec() {

        describe("in some context") {
            var view: UIView!

            beforeEach {
                // Set 10% tolerance to handle antialiasing issues
                setNimbleTolerance(0.1)
                setNimbleTestFolder("tests")
                view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 44, height: 44)))
                view.backgroundColor = .blue
            }

            it("has a valid snapshot") {
                expect(view).to(haveValidSnapshot())
                expect(view).to(haveValidSnapshot(named: "something custom"))
            }

            it("has a valid snapshot with a identifier") {
                expect(view).to(haveValidSnapshot(identifier: "bootstrap"))
                expect(view).to(haveValidSnapshot(named: "something custom", identifier: "bootstrap"))
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

            it("has a valid snapshot with model and OS in name and identifier") {
                // expect(view).to(recordDeviceAgnosticSnapshot(identifier: "bootstrap"))
                expect(view).to(haveValidDeviceAgnosticSnapshot(identifier: "bootstrap"))

                // expect(view).to(recordDeviceAgnosticSnapshot(named: "something custom with model and OS",
                //                                             identifier: "boostrap"))
                expect(view).to(haveValidDeviceAgnosticSnapshot(named: "something custom with model and OS",
                                                                identifier: "boostrap"))
            }

            it("has a valid snapshot with model and OS in name") {
                // expect(view).to(recordDeviceAgnosticSnapshot())
                expect(view).to(haveValidDeviceAgnosticSnapshot())

                // expect(view).to(recordDeviceAgnosticSnapshot(named: "something custom with model and OS"))
                expect(view).to(haveValidDeviceAgnosticSnapshot(named: "something custom with model and OS"))
            }

            it("has a valid snapshot when draw rect is turned on") {
                let view = CustomDrawRectView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
                view.backgroundColor = .white
                // expect(view).to(recordSnapshot(usesDrawRect: true))
                expect(view).to(haveValidSnapshot(usesDrawRect: true))

            }

            it("has a valid snapshot when draw rect is turned on and is using pretty syntax") {
                let view = CustomDrawRectView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
                view.backgroundColor = .white
                // expect(view) == recordSnapshot(usesDrawRect: true)
                expect(view) == snapshot(usesDrawRect: true)
            }

            it("handles recording with recordSnapshot") {
                // Recorded with:
                // expect(view) == recordSnapshot()
                expect(view) == snapshot()
            }

            it("respects tolerance") {
                // Image for this test has 0.5pt column (of 44pt) that is wrong.
                setNimbleTolerance(1)
                expect(view) == snapshot()
            }
        }
    }
}

final class CustomDrawRectView: UIView {
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        ctx.setFillColor(UIColor.red.cgColor)
        ctx.fill(CGRect(x: 5, y: 5, width: rect.width - 10, height: rect.height - 10))
    }
}
