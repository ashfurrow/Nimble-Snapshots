import Nimble
import UIKit

public func allContentSizeCategories() -> [UIContentSizeCategory] {
    return [
        .extraSmall, .small, .medium,
        .large, .extraLarge, .extraExtraLarge,
        .extraExtraExtraLarge, .accessibilityMedium,
        .accessibilityLarge, .accessibilityExtraLarge,
        .accessibilityExtraExtraLarge, .accessibilityExtraExtraExtraLarge
    ]
}

func shortCategoryName(_ category: UIContentSizeCategory) -> String {
    return category.rawValue.replacingOccurrences(of: "UICTContentSizeCategory", with: "")
}

func combinePredicates<T>(_ predicates: [Nimble.Matcher<T>],
                          deferred: (() -> Void)? = nil) -> Nimble.Matcher<T> {
    return Matcher { actualExpression in
        defer {
            deferred?()
        }

        let result = MatcherResult(status: .fail, message: .fail(""))
        return try predicates.reduce(result) { _, matcher -> MatcherResult in
            let result = try matcher.satisfies(actualExpression)
            return MatcherResult(status: MatcherStatus(bool: result.status == .matches),
                                 message: result.message)
        }
    }
}

public func haveValidDynamicTypeSnapshot<T: Snapshotable>(named name: String? = nil,
                                                          identifier: String? = nil,
                                                          usesDrawRect: Bool = false,
                                                          pixelTolerance: CGFloat? = nil,
                                                          tolerance: CGFloat? = nil,
                                                          sizes: [UIContentSizeCategory] = allContentSizeCategories(),
                                                          isDeviceAgnostic: Bool = false) -> Nimble.Matcher<T> {
    let mock = NBSMockedApplication()

    let predicates: [Nimble.Matcher<T>] = sizes.map { category in
        let sanitizedName = sanitizedTestName(name)
        let categorySuffix = shortCategoryName(category)
        let nameWithCategory = categorySuffix.isEmpty ? sanitizedName : "\(sanitizedName)_\(categorySuffix)"

        return Nimble.Matcher { actualExpression in
            mock.mockPreferredContentSizeCategory(category)
            updateTraitCollection(on: actualExpression)

            let predicate: Nimble.Matcher<T>
            if isDeviceAgnostic {
                predicate = haveValidDeviceAgnosticSnapshot(named: nameWithCategory, identifier: identifier,
                                                            usesDrawRect: usesDrawRect, pixelTolerance: pixelTolerance,
                                                            tolerance: tolerance)
            } else {
                predicate = haveValidSnapshot(named: nameWithCategory,
                                              identifier: identifier,
                                              usesDrawRect: usesDrawRect,
                                              pixelTolerance: pixelTolerance,
                                              tolerance: tolerance)
            }

            return try predicate.satisfies(actualExpression)
        }
    }

    return combinePredicates(predicates) {
        mock.stopMockingPreferredContentSizeCategory()
    }
}

public func recordDynamicTypeSnapshot<T: Snapshotable>(named name: String? = nil,
                                                       identifier: String? = nil,
                                                       usesDrawRect: Bool = false,
                                                       sizes: [UIContentSizeCategory] = allContentSizeCategories(),
                                                       isDeviceAgnostic: Bool = false) -> Nimble.Matcher<T> {
    let mock = NBSMockedApplication()

    let predicates: [Nimble.Matcher<T>] = sizes.map { category in
        let sanitizedName = sanitizedTestName(name)
        let categorySuffix = shortCategoryName(category)
        let nameWithCategory = categorySuffix.isEmpty ? sanitizedName : "\(sanitizedName)_\(categorySuffix)"

        return Nimble.Matcher { actualExpression in
            mock.mockPreferredContentSizeCategory(category)
            updateTraitCollection(on: actualExpression)

            let predicate: Nimble.Matcher<T>
            if isDeviceAgnostic {
                predicate = recordDeviceAgnosticSnapshot(named: nameWithCategory,
                                                         identifier: identifier,
                                                         usesDrawRect: usesDrawRect)
            } else {
                predicate = recordSnapshot(named: nameWithCategory, identifier: identifier, usesDrawRect: usesDrawRect)
            }

            return try predicate.satisfies(actualExpression)
        }
    }

    return combinePredicates(predicates) {
        mock.stopMockingPreferredContentSizeCategory()
    }
}

private func updateTraitCollection<T: Snapshotable>(on expression: Nimble.Expression<T>) {
    // swiftlint:disable:next force_try force_unwrapping
    let instance = try! expression.evaluate()!
    updateTraitCollection(on: instance)
}

private func updateTraitCollection(on element: Snapshotable) {

    guard let environment = element as? UITraitEnvironment else {
        return
    }

    if let vc = environment as? UIViewController {
        if vc.isViewLoaded {
            vc.beginAppearanceTransition(true, animated: false)
            vc.endAppearanceTransition()
        }
    }

    environment.traitCollectionDidChange(nil)

    if let view = environment as? UIView {
        for subview in view.subviews {
            updateTraitCollection(on: subview)
        }
    } else if let vc = environment as? UIViewController {
        #if swift(>=4.2)
            for child in vc.children {
                updateTraitCollection(on: child)
            }
        #else
            for child in vc.childViewControllers {
                updateTraitCollection(on: child)
            }
        #endif

        if vc.isViewLoaded {
            updateTraitCollection(on: vc.view)
        }
    }

    if let view = (environment as? UIView) ?? ((environment as? UIViewController)?.view) {
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    CATransaction.flush()
}
