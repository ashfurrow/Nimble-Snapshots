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
                view.backgroundColor = UIColor { traits -> UIColor in
                    if traits.userInterfaceStyle == .dark {
                        return .brown
                    } else {
                        return .blue
                    }
                }
            }

            it("has a valid snapshot") {
                expect(view).to(haveValidSnapshot(userInterfaceStyle: .light))
                expect(view).to(haveValidSnapshot(userInterfaceStyle: .dark))
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

            it("has a valid snapshot with model and OS in name ") {
                // expect(view).to(recordDeviceAgnosticSnapshot())
                expect(view).to(haveValidDeviceAgnosticSnapshot())

                // expect(view).to(recordDeviceAgnosticSnapshot(named: "something custom with model and OS"))
                expect(view).to(haveValidDeviceAgnosticSnapshot(named: "something custom with model and OS"))
            }

            // The easiest way to test this is a to have a view that is changed by UIAppearance
            // https://github.com/facebook/ios-snapshot-test-case/issues/91
            // If this is not using drawRect it will fail

            it("has a valid snapshot when draw rect is turned on ") {
                UIButton.appearance().tintColor = .red
                let button = UIButton(type: .contactAdd)

                // expect(button).to(recordSnapshot(usesDrawRect: true))
                expect(button).to(haveValidSnapshot(usesDrawRect: true))
            }

            it("has a valid snapshot when draw rect is turned on and is using pretty syntax") {
                UIButton.appearance().tintColor = .red
                let button = UIButton(type: .contactAdd)

                // expect(button) == recordSnapshot(usesDrawRect: true)
                expect(button) == snapshot(usesDrawRect: true)
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
