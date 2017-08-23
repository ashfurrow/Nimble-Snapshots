import XCTest

/// Helper class providing access to the currently executing XCTestCase instance, if any
@objc public final class CurrentTestCaseTracker: NSObject, XCTestObservation {
    @objc public static let shared = CurrentTestCaseTracker()

    private(set) var currentTestCase: XCTestCase?

    @objc public func testCaseWillStart(_ testCase: XCTestCase) {
        currentTestCase = testCase
    }

    @objc public func testCaseDidFinish(_ testCase: XCTestCase) {
        currentTestCase = nil
    }
}

extension XCTestCase {
    var sanitizedName: String? {
        let characterSet = CharacterSet(charactersIn: "[]+-")
        let name = self.name.components(separatedBy: characterSet).joined()

        if let quickClass = NSClassFromString("QuickSpec"), self.isKind(of: quickClass) {
            let className = String(describing: type(of: self))
            if let range = name.range(of: className), range.lowerBound == name.startIndex {
                return name.replacingCharacters(in: range, with: "")
                    .trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }

        return name
    }
}
