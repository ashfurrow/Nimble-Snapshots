//
//  BootstrapTests.swift
//  BootstrapTests
//
//  Created by Ash Furrow on 2014-08-07.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

import Quick
import Nimble
import UIKit

class BoostrapSpec: QuickSpec {
    override func spec() {
        describe("in some context", { () -> () in
            it("has valid snapshot") {
                let view = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: 44, height: 44)))
                view.backgroundColor = UIColor.blueColor()
                expect(view).to(haveValidSnapshot())
                expect(view).to(haveValidSnapshot(named: "something custom"))
            }
        });
    }
}
