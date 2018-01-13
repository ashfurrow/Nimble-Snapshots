# Nimble-Snapshots

## Next

* Migrate from FBSnapshotTestCase to iOSSnapshotTestCase - @freak4pc

## 6.3.0

* Xcode 9 / Swift 4 support - @danielsaidi

## 6.2.2

* Adds Carthage support for tvOS - @tsabend

## 6.2.1

* Fixes Carthage install dependency mismatch – @NachoSoto 

## 6.2.0

* Makes DynamicType tests to work with `adjustsFontForContentSizeCategory` property
  and with views that uses `traitCollectionDidChange:`. - @marcelofabri
* Trigger a view to be loaded prior to first `traitCollectionDidChange`
  call when doing dynamic type testing of a view controller - @yas375

## 6.1.0

* tvOS support for CocoaPods added. - @fousa

## 6.0.0

* Don't import Quick directly.
  This means you should add Quick to your Podfile if you want to use it. - @marcelofabri

## 5.1.0

* Removes OCMock dependency for DynamicType subspec - @marcelofabri
* Include all subspecs by default, allowing usage with Carthage - @marcelofabri

## 5.0.1

* Fixes Carthage installs of 5.0.0.

## 5.0.0

* Update the Cartfile to use always the latest stable release of Nimble and Quick.
* Fix issue with the installation using Carthage.
* Changed use of deprecated `MatcherFunc` to `Predicate` in favor of `Nimble v7.0.0`.
* Drops support for Swift 2.3 - @marcelofabri
* Adds device agnostic support for testing dynamic sizes - @fsaragoca
* Makes it possible to use it without Quick - @marcelofabri
* Support usesDrawRect when using PrettySyntax - @marcelofabri
* Exposes `FBSnapshotTest` as a public class with a public `setReferenceImagesDirectory` function - @ashfurrow

## 4.4.2

* Adds support for Carthage (Swift 3.0) - @juolgon & @lascorbe

## 4.4.1

* Adds support for Carthage (Swift 2.3) - @juolgon & @lascorbe

## 4.4.0

* Adds support for testing dynamic sizes - @bruno.mazzo

  You need the use the new subspec to enjoy this new feature:

  ```ruby
  pod 'Nimble-Snapshots/DynamicSize'
  ```

  Then you can use the new `haveValidDynamicSizeSnapshot` and `recordDynamicSizeSnapshot` matchers to use it:

  ```swift
  let sizes = ["SmallSize": CGSize(width: 44, height: 44),
               "MediumSize": CGSize(width: 88, height: 88),
               "LargeSize": CGSize(width: 132, height: 132)]

  // expect(view).to(recordDynamicSizeSnapshot(sizes: sizes))
  expect(view).to(haveValidDynamicSizeSnapshot(sizes: sizes))

  // You can also just test some sizes:
  expect(view).to(haveValidDynamicSizeSnapshot(sizes: sizes))

  // If you prefer the == syntax, we got you covered too:
  expect(view) == dynamicSizeSnapshot(sizes: sizes)
  expect(view) == dynamicSizeSnapshot(sizes: sizes)
  ```

  By default, the size will be set on the view using the frame property. To change this behavior
you can use the `ResizeMode` enum:

  ```swift
  public enum ResizeMode {
    case frame
    case constrains
    case block(resizeBlock: (UIView, CGSize)->())
    case custom(ViewResizer: ViewResizer)
  }
  ```
  To use the enum you can `expect(view) == dynamicSizeSnapshot(sizes: sizes, resizeMode: newResizeMode)`.
  For custom behavior you can use `ResizeMode.block`. The block will be call on every resize. Or you can
implement the `ViewResizer` protocol and resize yourself.
  The custom behavier can be use to record the views too.

For more info on usage, check the [dynamic sizes tests](Bootstrap/BootstrapTests/DynamicSizeTests.swift).

* Improved failure messages by removing the prefix ", got" - @MP0w

## 4.3.0

* Adds support for testing dynamic type - @marcelofabri

  You need the use the new subspec to enjoy this new feature:

    ```ruby
    pod 'Nimble-Snapshots/DynamicType'
    ```

  Then you can use the new `haveValidDynamicTypeSnapshot` and `recordDynamicTypeSnapshot` matchers to use it:

    ```swift
    // expect(view).to(recordDynamicTypeSnapshot()
    expect(view).to(haveValidDynamicTypeSnapshot())

    // You can also just test some sizes:
    expect(view).to(haveValidDynamicTypeSnapshot(sizes: [UIContentSizeCategoryExtraLarge]))

    // If you prefer the == syntax, we got you covered too:
    expect(view) == dynamicTypeSnapshot()
    expect(view) == dynamicTypeSnapshot(sizes: [UIContentSizeCategoryExtraLarge])
    ```

  Note that this will post an `UIContentSizeCategoryDidChangeNotification`, so your views/view controllers
  need to observe that and update themselves.

  For more info on usage, check the [dynamic type tests](Bootstrap/BootstrapTests/DynamicTypeTests.swift).

* Removes support for Xcode 7.3 and Swift 2.2 - @marcelofabri
* Adds Swift 2.3/3.0 support - @carezone

## 4.1.0

* Adds `tolerance` so you can specify tolerance of reference image differences – @mpurland

## 4.0.1

* Adds `recordSnapshot(name=nil)` so you can use `expect(thing) == recordSnapshot()` as this feels much nicer than
  writing `expect(thing).to( recordSnapshot() )` - I'm still not over this `to( thing() )`' bit in Quick. Looks messy. - @orta

## 4.0.0

* Nimble-Snapshots does not call `view?.drawViewHierarchyInRect(bounds, afterScreenUpdates: true)` on your views by default. - @orta

  If this is something that you need in order to get your snapshots passing, you should look at two options:

  - Adding the view to an existing window, then calling `drawViewHierarchyInRect:afterScreenUpdates:` - this
    is the technique that is used inside `FBSnapshotTestController`, which we now expose as an option in `recordSnapshot`
    and `haveValidSnapshot` as `usesDrawRect`

    ``` swift
        expect(imageView).to( recordSnapshot(usesDrawRect: true) )
        expect(imageView).to( haveValidSnapshot(usesDrawRect: true) )
    ```

    You can get more info on the [technique on this issue](https://github.com/facebook/ios-snapshot-test-case/issues/91)


  - Spending time looking in how you can remove Async code from your App. Or look for places where you are relying on a view structure
    which isn't set up in your tests. There are a bunch of examples in https://github.com/orta/pragmatic-testing on removing Async.

## 3.0.1

* Loosens dependency version. - @alesker

## 3.0.0

* Calls through to `drawViewHierarchyInRect` on every snapshot prior to snapshot being made – @ashfurrow

## 2.0.1

* Disables bitcode – @ashfurrow

## 2.0.0

* Name sanitizing, custom folders and more housekeeping - @colinta

## 1.2.0

* Device diagnostic code – @esttorhe

## 1.0.0

* Swift 2 support - @tibr

## 0.4

* Updates Quick and Numble to latest (requires Xcode 6.3+) - @andreamazz

## 0.3

* Adds pretty syntax support for snapshots with unspecified names - @ashfurrow

## 0.2

* Ensure all ReferenceImages folders are in the same root folder - @orta

## 0.1

* Updated to official repos of Quick and Nimble for beta 5 support - @ashfurrow
