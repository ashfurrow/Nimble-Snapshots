import Quick
import Nimble
import UIKit
import FBSnapshotTestCase

func allContentSizeCategories() -> [UIContentSizeCategory] {
    return [
        UIContentSizeCategoryExtraSmall, UIContentSizeCategorySmall, UIContentSizeCategoryMedium,
        UIContentSizeCategoryLarge, UIContentSizeCategoryExtraLarge, UIContentSizeCategoryExtraExtraLarge,
        UIContentSizeCategoryExtraExtraExtraLarge, UIContentSizeCategoryAccessibilityMedium,
        UIContentSizeCategoryAccessibilityLarge, UIContentSizeCategoryAccessibilityExtraLarge,
        UIContentSizeCategoryAccessibilityExtraExtraLarge, UIContentSizeCategoryAccessibilityExtraExtraExtraLarge
    ]
}

func shortCategoryName(category: UIContentSizeCategory) -> String {
    return category.stringByReplacingOccurrencesOfString("UICTContentSizeCategory", withString: "")
}

func combineMatchers<T>(matchers: [MatcherFunc<T>], ignoreFailures: Bool = false, deferred: () -> Void) -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        defer {
            deferred()
        }

        return try matchers.reduce(true) { acc, matcher -> Bool in
            guard acc || ignoreFailures else { return false }

            let result = try matcher.matches(actualExpression, failureMessage: failureMessage)
            return result && acc
        }
    }
}

public func haveValidDynamicTypeSnapshot(named name: String? = nil, usesDrawRect: Bool = false, tolerance: CGFloat? = nil, sizes: [UIContentSizeCategory] = allContentSizeCategories()) -> MatcherFunc<Snapshotable> {
    let mock = NBSMockedApplication()

    let matchers: [MatcherFunc<Snapshotable>] = sizes.map { category in
        let sanitizedName = _sanitizedTestName(name)
        let nameWithCategory = "\(sanitizedName)_\(shortCategoryName(category))"

        return MatcherFunc { actualExpression, failureMessage in
            mock.mockPrefferedContentSizeCategory(category as String)

            return try haveValidSnapshot(named: nameWithCategory, usesDrawRect: usesDrawRect, tolerance: tolerance).matches(actualExpression, failureMessage: failureMessage)
        }
    }

    return combineMatchers(matchers) {
        mock.stopMockingPrefferedContentSizeCategory()
    }
}

public func recordDynamicTypeSnapshot(named name: String? = nil, usesDrawRect: Bool = false, sizes: [UIContentSizeCategory] = allContentSizeCategories()) -> MatcherFunc<Snapshotable> {
    let mock = NBSMockedApplication()

    let matchers: [MatcherFunc<Snapshotable>] = sizes.map { category in
        let sanitizedName = _sanitizedTestName(name)
        let nameWithCategory = "\(sanitizedName)_\(shortCategoryName(category))"

        return MatcherFunc { actualExpression, failureMessage in
            mock.mockPrefferedContentSizeCategory(category as String)

            return try recordSnapshot(named: nameWithCategory, usesDrawRect: usesDrawRect).matches(actualExpression, failureMessage: failureMessage)
        }
    }

    return combineMatchers(matchers, ignoreFailures: true) {
        mock.stopMockingPrefferedContentSizeCategory()
    }
}
