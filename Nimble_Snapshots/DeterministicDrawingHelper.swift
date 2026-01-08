import ObjectiveC
import QuartzCore
import UIKit

enum DeterministicDrawingHelper {

    static func normalizeForSnapshot<T: Snapshotable>(_ view: T, completion: @escaping (T) -> Void) {
        guard let snapshotView = view.snapshotObject else {
            completion(view)
            return
        }

        snapshotView.setNeedsLayout()
        snapshotView.layoutIfNeeded()

        // Force all subviews to complete their layout
        normalizeViewHierarchyLayout(snapshotView)

        // Normalize drawing state for all custom drawRect views
        normalizeDrawRectViews(snapshotView)

        CATransaction.flush()

        snapshotView.setNeedsDisplay()

        // Allow one run loop cycle for any pending operations
        DispatchQueue.main.async {
            completion(view)
        }
    }

    private static func normalizeViewHierarchyLayout(_ view: UIView) {
        view.setNeedsLayout()
        view.layoutIfNeeded()

        for subview in view.subviews {
            normalizeViewHierarchyLayout(subview)
        }
    }

    private static func normalizeDrawRectViews(_ view: UIView) {
        // Check if this view overrides drawRect by checking if it has custom drawing
        let viewClass = type(of: view)
        let drawRectMethod = class_getInstanceMethod(viewClass, #selector(UIView.draw(_:)))
        let baseDrawRectMethod = class_getInstanceMethod(UIView.self, #selector(UIView.draw(_:)))

        if drawRectMethod != baseDrawRectMethod {
            // This view has custom drawRect implementation
            view.setNeedsDisplay()
            view.layer.setNeedsDisplay()
        }

        for subview in view.subviews {
            normalizeDrawRectViews(subview)
        }
    }
}
