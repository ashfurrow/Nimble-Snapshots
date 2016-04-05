# Nimble-Snapshots

## 4.0.1

* Nimble-Snapshots does not call `view?.drawViewHierarchyInRect(bounds, afterScreenUpdates: true)` on your views. - @orta

  If this is something that you need in order to get your snapshots passing, you should look at two options:

  - Adding the view to an existing window, then calling `drawViewHierarchyInRect:afterScreenUpdates:` - this
    is the technique that is used inside `FBSnapshotTestController`:

  ```objc
    UIWindow *window = [view isKindOfClass:[UIWindow class]] ? (UIWindow *)view : view.window;
    BOOL removeFromSuperview = NO;
    if (!window) {
        window = [[UIApplication sharedApplication] fb_strictKeyWindow];
    }

    if (!view.window && view != window) {
        [window addSubview:view];
        removeFromSuperview = YES;
    }

    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, 0);
    [view layoutIfNeeded];
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];

    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  ```

  - Spending time looking in how you can remove Async code from your App. There
    are a bunch of examples in https://github.com/orta/pragmatic-testing

  If support for this is super critical for someone, I'd accept a well tested config that allows toggling
  `FBSnapshotController`'s `usesDrawViewHierarchyInRect` bool, which should trigger this too.


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
