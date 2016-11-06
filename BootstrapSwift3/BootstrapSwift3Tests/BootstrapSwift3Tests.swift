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
            
            it("has a valid snapshot to all sizes") {
                
                let sizes = ["SmallSize": CGSize(width: 44, height: 44),
                             "MediumSize": CGSize(width: 88, height: 88),
                             "LargeSize": CGSize(width: 132, height: 132)]
                
                
                expect(view).to(haveValidDynamicSizeSnapshot(sizes: sizes))
//                expect(view).to(recordDynamicSizeSnapshot(sizes: sizes))
            }
            
            it("has a valid snapshot to all sizes (using == operator)") {
                
                let sizes = ["SmallSize": CGSize(width: 44, height: 44),
                             "MediumSize": CGSize(width: 88, height: 88),
                             "LargeSize": CGSize(width: 132, height: 132)]
                
                expect(view) == snapshot(sizes: sizes)
//                expect(view) == recordSnapshot(sizes: sizes)
            }
        }
    }
}
