# Nimble-Snapshots

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
