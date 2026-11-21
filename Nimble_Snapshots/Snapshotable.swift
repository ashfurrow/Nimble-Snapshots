#if canImport(SwiftUI)
    import Foundation
    import SwiftUI
    import UIKit

    /// Controls the rendering size of a SwiftUI snapshot.
    public enum SnapshotSize {
        /// Full device screen bounds.
        case device
        /// Fixed custom size.
        case fixed(CGSize)
        /// Smallest size that fits the view's content (default).
        ///
        /// The safe area is ignored, so the size is the same on every device. This requires iOS or tvOS 16.4 or
        /// later; on earlier versions the safe area is not ignored.
        case intrinsic
    }

    extension SwiftUI.View {
        func snapshotable(size: SnapshotSize) -> Snapshotable {
            let controller = UIHostingController(rootView: self)

            // The safe area is ignored for `.intrinsic` so that the fitted size is the size of the content
            // alone, rather than the content plus the status bar or Dynamic Island inset of the device.
            if case .intrinsic = size, #available(iOS 16.4, tvOS 16.4, *) {
                controller.safeAreaRegions = []
            }

            let frame: CGRect = switch size {
            case .device:
                UIScreen.main.bounds
            case let .fixed(cgSize):
                CGRect(origin: .zero, size: cgSize)
            case .intrinsic:
                UIScreen.main.bounds
            }

            controller.view.frame = frame

            let window = UIWindow(frame: frame)
            window.rootViewController = controller
            window.makeKeyAndVisible()
            controller.view.layoutIfNeeded()
            RunLoop.main.run(until: Date())

            if case .intrinsic = size {
                let fitted = controller.sizeThatFits(in: frame.size)
                controller.view.frame = CGRect(origin: .zero, size: fitted)
                controller.view.layoutIfNeeded()
            }

            return controller
        }
    }
#endif
