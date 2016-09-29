import Quick
import Nimble
import Nimble_Snapshots
import Bootstrap

class DynamicTypeTests: QuickSpec {
    override func spec() {
        describe("in some context", {
            var view: UIView!

            beforeEach {
                setNimbleTolerance(0)
                setNimbleTestFolder("tests")
                view = DynamicTypeView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
            }

            it("has a valid snapshot for all content size categories (iOS 9)") {
                let version = NSProcessInfo.processInfo().operatingSystemVersion
                guard version.majorVersion == 9 && version.minorVersion == 3 else {
                    return
                }

                expect(view).to(haveValidDynamicTypeSnapshot())
                expect(view).to(haveValidDynamicTypeSnapshot(named: "something custom"))
            }

            it("has a valid snapshot for a single content size category (iOS 9)") {
                let version = NSProcessInfo.processInfo().operatingSystemVersion
                guard version.majorVersion == 9 && version.minorVersion == 3 else {
                    return
                }

                expect(view).to(haveValidDynamicTypeSnapshot(sizes: [UIContentSizeCategoryExtraLarge]))
                expect(view).to(haveValidDynamicTypeSnapshot(named: "something custom", sizes: [UIContentSizeCategoryExtraLarge]))
            }

            it("has a valid snapshot for all content size categories (iOS 10)") {
                let version = NSProcessInfo.processInfo().operatingSystemVersion
                guard version.majorVersion == 10 && version.minorVersion == 0 else {
                    return
                }

                expect(view).to(haveValidDynamicTypeSnapshot())

                let name = "something custom_\(version.majorVersion)_\(version.minorVersion)"
                expect(view).to(haveValidDynamicTypeSnapshot(named: name))
            }

            it("has a valid snapshot for a single content size category (iOS 10)") {
                let version = NSProcessInfo.processInfo().operatingSystemVersion
                guard version.majorVersion == 10 && version.minorVersion == 0 else {
                    return
                }

                expect(view).to(haveValidDynamicTypeSnapshot(sizes: [UIContentSizeCategoryExtraLarge]))

                let name = "something custom_\(version.majorVersion)_\(version.minorVersion)"
                expect(view).to(haveValidDynamicTypeSnapshot(named: name, sizes: [UIContentSizeCategoryExtraLarge]))
            }
        })
    }
}
