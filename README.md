Nimble-Snapshots
=============================

[Nimble](https://github.com/Quick/Nimble) matchers for [FBSnapshotTestCase](https://github.com/facebook/ios-snapshot-test-case).
Highly derivative of [Expecta Matchers for FBSnapshotTestCase](https://github.com/dblock/ios-snapshot-test-case-expecta). 

![](http://static.ashfurrow.com/gifs/click.gif)

Using This Library
------------------
You'll need the [Quick](http://github.com/Quick/Quick), [Nimble](http://github.com/Quick/Nimble),
and FBSnapshotTestCase linked into your test target (through submodules, Carthage,
or pre-release CocoaPods). Next, add this library (either with CocoaPods, as a 
new framework, or just the two `.swift` files). Now you can 

Your tests will look something like the following.

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

There are some options for testing the validity of snapshots. Snapshots can be
given a name:

```swift
expect(view).to(haveValidSnapshot(named: "some custom name"))
```

We also have a prettier syntax for custom-named snapshots:

```swift
expect(view) == snapshot"some custom name")
```

To record snapshots, just replace `haveValidSnapshot()` with `recordSnapshot()`
and `haveValidSnapshot(named:)` with `recordSnapshot(named:)`. We also have a 
handy emoji operator. 

```swift
📷(view)
📷(view, "some custom name")
```

If you have any questions or run into any trouble, feel free to open an issue
on this repo. 
