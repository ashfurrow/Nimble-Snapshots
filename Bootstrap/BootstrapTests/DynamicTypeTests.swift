import Bootstrap
import Nimble
import Nimble_Snapshots
import Quick

class DynamicTypeTests: QuickSpec {
    override func spec() {
        describe("in some context") {
            var view: UIView!

            beforeEach {
                setNimbleTolerance(0)
                setNimbleTestFolder("tests")
                view = DynamicTypeView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
            }

            it("has a valid snapshot for all content size categories (iOS 9)") {
                let version = ProcessInfo.processInfo.operatingSystemVersion
                guard version.majorVersion == 9 && version.minorVersion == 3 else {
                    return
                }

                expect(view).to(haveValidDynamicTypeSnapshot())
                let name = "something custom_\(version.majorVersion)_\(version.minorVersion)"
                expect(view).to(haveValidDynamicTypeSnapshot(named: name))
            }

            it("has a valid snapshot for a single content size category (iOS 9)") {
                let version = ProcessInfo.processInfo.operatingSystemVersion
                guard version.majorVersion == 9 && version.minorVersion == 3 else {
                    return
                }

                expect(view).to(haveValidDynamicTypeSnapshot(sizes: [.extraLarge]))
                let name = "something custom_\(version.majorVersion)_\(version.minorVersion)"
                expect(view).to(haveValidDynamicTypeSnapshot(named: name, sizes: [.extraLarge]))
            }

            it("has a valid snapshot for all content size categories (iOS 10)") {
                let version = ProcessInfo.processInfo.operatingSystemVersion
                guard version.majorVersion == 10 && version.minorVersion == 2 else {
                    return
                }

                expect(view).to(haveValidDynamicTypeSnapshot())

                let name = "something custom_\(version.majorVersion)_\(version.minorVersion)"
                expect(view).to(haveValidDynamicTypeSnapshot(named: name))
            }

            it("has a valid snapshot for a single content size category (iOS 10)") {
                let version = ProcessInfo.processInfo.operatingSystemVersion
                guard version.majorVersion == 10 && version.minorVersion == 2 else {
                    return
                }

                expect(view).to(haveValidDynamicTypeSnapshot(sizes: [.extraLarge]))

                let name = "something custom_\(version.majorVersion)_\(version.minorVersion)"
                expect(view).to(haveValidDynamicTypeSnapshot(named: name, sizes: [.extraLarge]))
            }

            it("has a valid pretty-syntax snapshot (iOS 9)") {
                let version = ProcessInfo.processInfo.operatingSystemVersion
                guard version.majorVersion == 9 && version.minorVersion == 3 else {
                    return
                }

                expect(view) == dynamicTypeSnapshot()
            }

            it("has a valid pretty-syntax snapshot (iOS 10)") {
                let version = ProcessInfo.processInfo.operatingSystemVersion
                guard version.majorVersion == 10 && version.minorVersion == 0 else {
                    return
                }

                expect(view) == dynamicTypeSnapshot()
            }

            it("has a valid pretty-syntax snapshot for only one size category (iOS 9)") {
                let version = ProcessInfo.processInfo.operatingSystemVersion
                guard version.majorVersion == 9 && version.minorVersion == 3 else {
                    return
                }

                expect(view) == dynamicTypeSnapshot(sizes: [.extraLarge])
            }

            it("has a valid pretty-syntax snapshot for only one size category (iOS 10)") {
                let version = ProcessInfo.processInfo.operatingSystemVersion
                guard version.majorVersion == 10 && version.minorVersion == 0 else {
                    return
                }

                expect(view) == dynamicTypeSnapshot(sizes: [.extraLarge])
            }

            it("has a valid snapshot with model and OS in name") {
                expect(view).to(haveValidDynamicTypeSnapshot(isDeviceAgnostic: true))
                expect(view).to(haveValidDynamicTypeSnapshot(named: "something custom with model and OS", isDeviceAgnostic: true))
            }
        }
    }
}
