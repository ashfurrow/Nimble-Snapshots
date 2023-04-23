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

func combinePredicates<T>(_ predicates: [Predicate<T>],
                          deferred: (() -> Void)? = nil) -> Predicate<T> {
    return Predicate { actualExpression in
        defer {
            deferred?()
        }

        let result = PredicateResult(status: .fail, message: .fail(""))
        return try predicates.reduce(result) { _, matcher -> PredicateResult in
            let result = try matcher.satisfies(actualExpression)
            return PredicateResult(status: PredicateStatus(bool: result.status == .matches),
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
                                         isDeviceAgnostic: Bool = false,
                                         userInterfaceStyle: UIUserInterfaceStyle? = nil) -> Predicate<T> {
    let mock = NBSMockedApplication()

    let predicates: [Predicate<T>] = sizes.map { category in
        let sanitizedName = sanitizedTestName(name)
        var nameWithCategory = "\(sanitizedName)_\(shortCategoryName(category))"
        if let userInterfaceStyle = userInterfaceStyle, let userInterfaceStyleIdentifier = userInterfaceStyle.identifier {
            nameWithCategory += "_\(userInterfaceStyleIdentifier)"
        }

        return Predicate { actualExpression in
            mock.mockPreferredContentSizeCategory(category)
            updateTraitCollection(on: actualExpression)

            let predicate: Predicate<T>
            if isDeviceAgnostic {
                predicate = haveValidDeviceAgnosticSnapshot(named: nameWithCategory, identifier: identifier,
                                                            usesDrawRect: usesDrawRect, pixelTolerance: pixelTolerance,
                                                            tolerance: tolerance,
                                                            userInterfaceStyle: userInterfaceStyle)
            } else {
                predicate = haveValidSnapshot(named: nameWithCategory,
                                              identifier: identifier,
                                              usesDrawRect: usesDrawRect,
                                              pixelTolerance: pixelTolerance,
                                              tolerance: tolerance,
                                              userInterfaceStyle: userInterfaceStyle)
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
                                      isDeviceAgnostic: Bool = false,
                                      userInterfaceStyle: UIUserInterfaceStyle? = nil) -> Predicate<T> {
    let mock = NBSMockedApplication()

    let predicates: [Predicate<T>] = sizes.map { category in
        let sanitizedName = sanitizedTestName(name)
        var nameWithCategory = "\(sanitizedName)_\(shortCategoryName(category))"
        if let userInterfaceStyle = userInterfaceStyle, let userInterfaceStyleIdentifier = userInterfaceStyle.identifier {
            nameWithCategory += "_\(userInterfaceStyleIdentifier)"
        }

        return Predicate { actualExpression in
            mock.mockPreferredContentSizeCategory(category)
            updateTraitCollection(on: actualExpression)

            let predicate: Predicate<T>
            if isDeviceAgnostic {
                predicate = recordDeviceAgnosticSnapshot(named: nameWithCategory,
                                                         identifier: identifier,
                                                         usesDrawRect: usesDrawRect,
                                                         userInterfaceStyle: userInterfaceStyle)
            } else {
                predicate = recordSnapshot(named: nameWithCategory,
                                           identifier: identifier,
                                           usesDrawRect: usesDrawRect,
                                           userInterfaceStyle: userInterfaceStyle)
            }

            return try predicate.satisfies(actualExpression)
        }
    }

    return combinePredicates(predicates) {
        mock.stopMockingPreferredContentSizeCategory()
    }
}

private func updateTraitCollection<T: Snapshotable>(on expression: Expression<T>) {
    // swiftlint:disable:next force_try force_unwrapping
    let instance = try! expression.evaluate()!
    updateTraitCollection(on: instance)
}

private func updateTraitCollection(on element: Snapshotable) {
    if let environment = element as? UITraitEnvironment {
        if let vc = environment as? UIViewController {
            vc.beginAppearanceTransition(true, animated: false)
            vc.endAppearanceTransition()
        }

        environment.traitCollectionDidChange(nil)

        if let view = environment as? UIView {
            view.subviews.forEach(updateTraitCollection(on:))
        } else if let vc = environment as? UIViewController {
            #if swift(>=4.2)
            vc.children.forEach(updateTraitCollection(on:))
            #else
            vc.childViewControllers.forEach(updateTraitCollection(on:))
            #endif

            if vc.isViewLoaded {
                updateTraitCollection(on: vc.view)
            }
        }
    }
}
