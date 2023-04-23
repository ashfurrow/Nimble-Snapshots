import Nimble
import Nimble_Snapshots
import Quick

final class BootstrapCustomFormatTests: QuickSpec {

    override func spec() {

        describe("in some context") {
            var view: UIView!

            beforeEach {
                setNimbleTestFolder("CustomFolder")
                view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 44, height: 44)))
                view.backgroundColor = UIColor { traits -> UIColor in
                    if traits.userInterfaceStyle == .dark {
                        return .brown
                    } else {
                        return .blue
                    }
                }
            }

            it("fails to find the snapshots due to the custom folder") {
                expect(view).notTo(haveValidSnapshot(named: "something custom"))
                expect(view).notTo(haveValidSnapshot(named: "something custom"))
            }

            it("finds the snapshots using a custom images directory") {
                expect(view).to(recordSnapshot())
            }

            it("finds device agnostic snapshots with custom images directory") {
                expect(view).to(recordDeviceAgnosticSnapshot())
            }

            it("find the snapshot using a custom image directory for light and dark mode") {
                expect(view).to(recordSnapshot(userInterfaceStyle: .light))
                expect(view).to(recordSnapshot(userInterfaceStyle: .dark))
            }
        }
    }
}
