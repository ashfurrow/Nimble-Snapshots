import Quick
import Nimble
import Nimble_Snapshots
import Bootstrap

class DynamicSizeTests: QuickSpec {
    override func spec() {
        describe("in some context", {
            
            var view: UIView!
            let sizes = ["SmallSize": CGSize(width: 44, height: 44),
                "MediumSize": CGSize(width: 88, height: 88),
                "LargeSize": CGSize(width: 132, height: 132)]
            
            beforeEach {
                setNimbleTolerance(0)
                setNimbleTestFolder("tests")
            }
            
            context("using only frame") {
                var view: UIView!
                
                beforeEach {
                    view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
                    view.backgroundColor = UIColor.blueColor()
                }
                
                it("has a valid snapshot to all sizes") {
    
                    expect(view).to(haveValidDynamicSizeSnapshot(sizes: sizes))
//                    expect(view).to(recordDynamicSizeSnapshot(sizes: sizes))
                }
                
                it("has a valid snapshot to all sizes (using == operator)") {
            
                    expect(view) == snapshot(sizes: sizes)
//                    expect(view) == recordSnapshot(sizes: sizes)
                }
            }
            
            context("using new constrains") {
                beforeEach {
                    view = UIView()
                    view.backgroundColor = UIColor.blueColor()
                    view.autoresizingMask = []
                    view.translatesAutoresizingMaskIntoConstraints = false
                }
                
                it("has a valid snapshot to all sizes") {
                    
                    expect(view).to(haveValidDynamicSizeSnapshot(sizes: sizes, resizeMode: .constrains))
//                    expect(view).to(recordDynamicSizeSnapshot(sizes: sizes, resizeMode: .constrains))
                }
                
                it("has a valid snapshot to all sizes (using == operator)") {
                    
                    expect(view) == snapshot(sizes: sizes, resizeMode: .constrains)
//                    expect(view) == recordSnapshot(sizes: sizes, resizeMode: .constrains)
                }
            }
            
            context("using constrains from view") {
                beforeEach {
                    view = UIView()
                    view.backgroundColor = UIColor.blueColor()
                    view.autoresizingMask = []
                    view.translatesAutoresizingMaskIntoConstraints = false
                    view.widthAnchor.constraintEqualToConstant(10).active = true
                    view.heightAnchor.constraintEqualToConstant(10).active = true
                }
                
                it("has a valid snapshot to all sizes") {
                    expect(view).to(haveValidDynamicSizeSnapshot(sizes: sizes, resizeMode: .constrains))
//                    expect(view).to(recordDynamicSizeSnapshot(sizes: sizes, resizeMode: .constrains))
                }
                
                it("has a valid snapshot to all sizes (using == operator)") {
                    expect(view) == snapshot(sizes: sizes, resizeMode: .constrains)
//                    expect(view) == recordSnapshot(sizes: sizes, resizeMode: .constrains)
                }
            }
            
            context("using block") {
                beforeEach {
                    view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
                    view.backgroundColor = UIColor.blueColor()
                }
                
                it("has a valid snapshot to all sizes") {
                    expect(view).to(haveValidDynamicSizeSnapshot(sizes: sizes, resizeMode: .block(resizeBlock: { (view, size) in
                        view.frame = CGRect(origin: CGPoint.zero, size: size)
                        view.layoutIfNeeded()
                    })))
//                    expect(view).to(recordDynamicSizeSnapshot(sizes: sizes, resizeMode: .block(resizeBlock: { (view, size) in
//                        view.frame = CGRect(origin: CGPoint.zero, size: size)
//                        view.layoutIfNeeded()
//                    })))
                }
                
                it("has a valid snapshot to all sizes (using == operator)") {
                    expect(view) == snapshot(sizes: sizes, resizeMode: .block(resizeBlock: { (view, size) in
                        view.frame = CGRect(origin: CGPoint.zero, size: size)
                        view.layoutIfNeeded()
                    }))
//                    expect(view) == recordSnapshot(sizes: sizes, resizeMode: .block(resizeBlock: { (view, size) in
//                        view.frame = CGRect(origin: CGPoint.zero, size: size)
//                        view.layoutIfNeeded()
//                    }))
                }
            }

            
            context("using custom resizer") {
                beforeEach {
                    view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
                    view.backgroundColor = UIColor.blueColor()
                }
                
                it("has a valid snapshot to all sizes") {
                    let resizer = CustomResizer()
                    expect(view).to(haveValidDynamicSizeSnapshot(sizes: sizes, resizeMode: .custom(ViewResizer: resizer)))
                    expect(resizer.used) == 3
//                    expect(view).to(recordDynamicSizeSnapshot(sizes: sizes, resizeMode: .custom(ViewResizer: resizer)))
                }
                
                it("has a valid snapshot to all sizes (using == operator)") {
                    
                    let resizer = CustomResizer()
                    expect(view) == snapshot(sizes: sizes, resizeMode: .custom(ViewResizer: resizer))
                    expect(resizer.used) == 3
//                    expect(view) == recordSnapshot(sizes: sizes, resizeMode: .custom(ViewResizer: resizer))
                }
            }

        })
    }
}

class CustomResizer: ViewResizer {
    var used = 0
    
    func resize(view view: UIView, for size: CGSize) {
        view.frame = CGRect(origin: CGPoint.zero, size: size)
        view.layoutIfNeeded()
        used += 1
    }
}
