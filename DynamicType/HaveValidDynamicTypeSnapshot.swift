import Quick
import Nimble
import UIKit
import FBSnapshotTestCase

func allContentSizeCategories() -> [UIContentSizeCategory] {
    #if swift(>=3.0)
        return [
            .extraSmall, .small, .medium,
            .large, .extraLarge, .extraExtraLarge,
            .extraExtraExtraLarge, .accessibilityMedium,
            .accessibilityLarge, .accessibilityExtraLarge,
            .accessibilityExtraExtraLarge, .accessibilityExtraExtraExtraLarge
        ]
    #else
        return [
            UIContentSizeCategoryExtraSmall, UIContentSizeCategorySmall, UIContentSizeCategoryMedium,
            UIContentSizeCategoryLarge, UIContentSizeCategoryExtraLarge, UIContentSizeCategoryExtraExtraLarge,
            UIContentSizeCategoryExtraExtraExtraLarge, UIContentSizeCategoryAccessibilityMedium,
            UIContentSizeCategoryAccessibilityLarge, UIContentSizeCategoryAccessibilityExtraLarge,
            UIContentSizeCategoryAccessibilityExtraExtraLarge, UIContentSizeCategoryAccessibilityExtraExtraExtraLarge
        ]
    #endif
}

func shortCategoryName(_ category: UIContentSizeCategory) -> String {
    #if swift(>=3.0)
        return category.rawValue.replacingOccurrences(of: "UICTContentSizeCategory", with: "")
    #else
        return category.stringByReplacingOccurrencesOfString("UICTContentSizeCategory", withString: "")
    #endif
}

func combineMatchers<T>(_ matchers: [MatcherFunc<T>], ignoreFailures: Bool = false, deferred: (() -> Void)? = nil) -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        defer {
            deferred?()
        }

        return try matchers.reduce(true) { acc, matcher -> Bool in
            guard acc || ignoreFailures else { return false }

            let result = try matcher.matches(actualExpression, failureMessage: failureMessage)
            return result && acc
        }
    }
}

public func haveValidDynamicTypeSnapshot(named name: String? = nil, usesDrawRect: Bool = false, tolerance: CGFloat? = nil, sizes: [UIContentSizeCategory] = allContentSizeCategories(), isDeviceAgnostic: Bool = false) -> MatcherFunc<Snapshotable> {
    let mock = NBSMockedApplication()

    let matchers: [MatcherFunc<Snapshotable>] = sizes.map { category in
        let sanitizedName = _sanitizedTestName(name)
        let nameWithCategory = "\(sanitizedName)_\(shortCategoryName(category))"

        return MatcherFunc { actualExpression, failureMessage in
            #if swift(>=3.0)
                mock.mockPrefferedContentSizeCategory(category)
            #else
                mock.mockPrefferedContentSizeCategory(category as String)
            #endif

            let matcher: MatcherFunc<Snapshotable>
            if isDeviceAgnostic {
                matcher = haveValidDeviceAgnosticSnapshot(named: nameWithCategory, usesDrawRect: usesDrawRect, tolerance: tolerance)
            } else {
                matcher = haveValidSnapshot(named: nameWithCategory, usesDrawRect: usesDrawRect, tolerance: tolerance)
            }

            return try matcher.matches(actualExpression, failureMessage: failureMessage)
        }
    }

    return combineMatchers(matchers) {
        mock.stopMockingPrefferedContentSizeCategory()
    }
}

public func recordDynamicTypeSnapshot(named name: String? = nil, usesDrawRect: Bool = false, sizes: [UIContentSizeCategory] = allContentSizeCategories(), isDeviceAgnostic: Bool = false) -> MatcherFunc<Snapshotable> {
    let mock = NBSMockedApplication()

    let matchers: [MatcherFunc<Snapshotable>] = sizes.map { category in
        let sanitizedName = _sanitizedTestName(name)
        let nameWithCategory = "\(sanitizedName)_\(shortCategoryName(category))"

        return MatcherFunc { actualExpression, failureMessage in
            #if swift(>=3.0)
                mock.mockPrefferedContentSizeCategory(category)
            #else
                mock.mockPrefferedContentSizeCategory(category as String)
            #endif

            let matcher: MatcherFunc<Snapshotable>
            if isDeviceAgnostic {
                matcher = recordDeviceAgnosticSnapshot(named: nameWithCategory, usesDrawRect: usesDrawRect)
            } else {
                matcher = recordSnapshot(named: nameWithCategory, usesDrawRect: usesDrawRect)
            }

            return try matcher.matches(actualExpression, failureMessage: failureMessage)
        }
    }

    return combineMatchers(matchers, ignoreFailures: true) {
        mock.stopMockingPrefferedContentSizeCategory()
    }
}
