#if canImport(SwiftUI)
    import Foundation
    import SwiftUI
    import UIKit

    /// Controls the rendering size of a SwiftUI snapshot.
    public enum SnapshotSize {
        /// Full device screen bounds (default).
        case device
        /// Fixed custom size.
        case fixed(CGSize)
        /// Smallest size that fits the view's content.
        case intrinsic
    }

    extension SwiftUI.View {
        func snapshotable(size: SnapshotSize) -> Snapshotable {
            let controller = UIHostingController(rootView: self)

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
