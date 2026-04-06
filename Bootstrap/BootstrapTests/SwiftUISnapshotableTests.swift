#if canImport(SwiftUI)
    import Nimble
    import Quick
    import SwiftUI

    @testable import Nimble_Snapshots

    @MainActor
    final class SwiftUISnapshotableTests: QuickSpec {

        override func spec() {
            describe("SwiftUI snapshot helpers") {
                it("sets requested fixed size") {
                    let targetSize = CGSize(width: 120, height: 45)

                    let snapshotable = FixedSizeView().snapshotable(size: .fixed(targetSize))
                    let snapshotView = snapshotable.snapshotObject

                    expect(snapshotView).toNot(beNil())
                    expect(snapshotView?.bounds.width).to(beCloseTo(targetSize.width, within: 0.5))
                    expect(snapshotView?.bounds.height).to(beCloseTo(targetSize.height, within: 0.5))
                    
                    expect(snapshotable).to(haveValidSnapshot())
                }

                it("uses screen bounds for device size") {
                    let snapshotable = FixedSizeView().snapshotable(size: .device)
                    let snapshotView = snapshotable.snapshotObject

                    let expected = UIScreen.main.bounds.size
                    expect(snapshotView).toNot(beNil())
                    expect(snapshotView?.bounds.width).to(beCloseTo(expected.width, within: 0.5))
                    expect(snapshotView?.bounds.height).to(beCloseTo(expected.height, within: 0.5))
                    
                    expect(snapshotable).to(haveValidSnapshot())
                }

                it("fits intrinsic size to content") {
                    let snapshotable = FixedSizeView().snapshotable(size: .intrinsic)
                    let snapshotView = snapshotable.snapshotObject
                    let size = snapshotView?.bounds.size
                    let deviceSize = UIScreen.main.bounds.size

                    expect(snapshotView).toNot(beNil())
                    expect(size?.width).to(beGreaterThan(0))
                    expect(size?.height).to(beGreaterThan(0))
                    expect(size?.width).to(beLessThanOrEqualTo(deviceSize.width))
                    expect(size?.height).to(beLessThanOrEqualTo(deviceSize.height))
                    expect(size?.width).to(beCloseTo(80, within: 1))
                    expect(size?.height).to(beCloseTo(50, within: 1))
                    
                    expect(snapshotable).to(haveValidSnapshot())
                }

                it("exposes SwiftUI matcher factories") {
                    let fixed = SnapshotSize.fixed(CGSize(width: 100, height: 40))

                    _ = haveValidSnapshot(named: "swiftui", size: fixed) as Nimble.Matcher<FixedSizeView>
                    _ = recordSnapshot(named: "swiftui", size: fixed) as Nimble.Matcher<FixedSizeView>
                    _ = haveValidDynamicTypeSnapshot(named: "swiftui",
                                                     size: fixed,
                                                     sizes: [.large]) as Nimble.Matcher<FixedSizeView>
                    _ = recordDynamicTypeSnapshot(named: "swiftui",
                                                  size: fixed,
                                                  sizes: [.large]) as Nimble.Matcher<FixedSizeView>
                }
            }
        }
    }

    private struct FixedSizeView: View {
        var body: some View {
            Color.red
                .frame(width: 80, height: 30)
        }
    }
#endif
