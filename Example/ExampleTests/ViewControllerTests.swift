//
//  ViewControllerTests.swift
//  ExampleTests
//
//  Created by João Lucas on 23/09/23.
//

import UIKit
import Quick
import Nimble
import Nimble_Snapshots
@testable import Example

final class ViewControllerTests: QuickSpec {
    override class func spec() {
        describe("ViewController Tests") {
            
            it("should validate layout") {
                let controller = ViewController()
                
                //expect(controller) == recordSnapshot()
                expect(controller) == snapshot()
            }
            
            it("has a valid snapshot to all sizes") {
                let sizes = [
                    "SmallSize": CGSize(width: 44, height: 44),
                    "MediumSize": CGSize(width: 88, height: 88),
                    "LargeSize": CGSize(width: 132, height: 132)
                ]
                
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
                view.backgroundColor = .red
                
                //expect(view).to(recordDynamicSizeSnapshot(sizes: sizes))
                expect(view).to(haveValidDynamicSizeSnapshot(sizes: sizes))
            }
            
            it("should validate button") {
                UIButton.appearance().tintColor = .blue
                let button = UIButton(type: .contactAdd)
                
                //expect(button).to(recordSnapshot(usesDrawRect: true))
                expect(button).to(haveValidSnapshot(usesDrawRect: true))
            }
        }
    }
}
