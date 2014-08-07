Nimble-Snapshots
=============================

[Nimble](https://github.com/Quick/Nimble) matchers for [FBSnapshotTestCase](https://github.com/facebook/ios-snapshot-test-case).
Highly derivative of [Expecta Matchers for FBSnapshotTestCase](https://github.com/dblock/ios-snapshot-test-case-expecta). 

Setup
----------------

Currently, set up is kind of a pain. That's because Nimble doesn't support 
Xcode 6 beta 5, yet. Additionally, I need them to merge my [pull request](https://github.com/Quick/Nimble/pull/16)
making the members of one of their classes explicitly public. So, you'll need to
use my [fork](https://github.com/AshFurrow/Nimble-Snapshots) of Nimble for now.
(And since [Quick](https://github.com/Quick/Quick) doesn't support Xcode 6 beta 
5 yet, either, you'll need a [fork](https://github.com/tokorom/Quick) that does.)

This project, naturally, relies on FBSnapshotTestCase. However, due to some 
strange errors I was getting with a CocoaPods-installed version of that library,
I've had to resort to using git submodules. 

So add your submodules for Quick, Nimble, and FBSnapshotTestCase, as well as a 
final one for this repository.

```sh
git submodule add git@github.com:tokorom/Quick.git submodules/Quick
git submodule add git@github.com:AshFurrow/Nimble.git submodules/Nimble
git submodule add git@github.com:facebook/ios-snapshot-test-case.git submodules/FBSnapshotTestCase
git submodule add git@github.com:AshFurrow/Nimble-Snapshots.git submodules/Nimble-Snapshots
git submodule init
git submodule update

```

Now [follow the instructions](https://github.com/Quick/Quick#2-add-quickxcodeproj-and-nimblexcodeproj-to-your-test-target)
for adding Quick and Nimble to your Xcode project. That's the easy part. You'll 
need to drag the following files into your project's *test* target.

* FBSnapshotTestCase.h
* FBSnapshotTestCase.m
* FBSnapshotTestController.h
* FBSnapshotTestController.m
* UIImage+Compare.h
* UIImage+Compare.m
* UIImage+Diff.h
* UIImage+Diff.m

Finally, drag in the `HaveValidSnapshot.swift` file from this repo. Since it 
relies on some Objective-C code in the FBSnapshotTestCase library, you'll need 
to add the following line to an [Objective-C bridging header](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html#//apple_ref/doc/uid/TP40014216-CH10-XID_79).

```objc
#import "FBSnapshotTestController.h"
```

Alrighty! We're all set. Your tests will look something like the following.

```swift
import Quick
import Nimble
import UIKit

class MySpec: QuickSpec {
    override func spec() {
        describe("in some context", { () -> () in
            it("has valid snapshot") {
                let view = ... // some view you want to test
                expect(view).to(haveValidSnapshot())
            }
        });
    }
}
```

If you have any questions or run into any trouble, feel free to open an issue
on this repo. 
