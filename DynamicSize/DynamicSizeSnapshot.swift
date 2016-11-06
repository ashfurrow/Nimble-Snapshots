import Foundation
import FBSnapshotTestCase
import UIKit
import Nimble
import QuartzCore
import Quick

public struct DynamicSizeSnapshot {
    let name: String?
    let record: Bool
    let sizes: [String: CGSize]
    
    init(name: String?, record: Bool, sizes: [String: CGSize]) {
        self.name = name
        self.record = record
        self.sizes = sizes
    }
}

public func snapshot(_ name: String? = nil, sizes: [String: CGSize]) -> DynamicSizeSnapshot {
    return DynamicSizeSnapshot(name: name, record: false, sizes: sizes)
}

public func haveValidDynamicSizeSnapshot(named name: String? = nil, sizes: [String: CGSize], usesDrawRect: Bool=false, tolerance: CGFloat? = nil) -> MatcherFunc<Snapshotable> {
    return MatcherFunc { actualExpression, failureMessage in
        return performDynamicSizeSnapshotTest(name, sizes: sizes, usesDrawRect: usesDrawRect, actualExpression: actualExpression, failureMessage: failureMessage, tolerance: tolerance, isRecord: false)
    }
}

func performDynamicSizeSnapshotTest(_ name: String?, sizes: [String: CGSize], isDeviceAgnostic: Bool=false, usesDrawRect: Bool=false, actualExpression: Expression<Snapshotable>, failureMessage: FailureMessage, tolerance: CGFloat? = nil, isRecord: Bool) -> Bool {
    let instance = try! actualExpression.evaluate()!
    let testFileLocation = actualExpression.location.file
    let referenceImageDirectory = _getDefaultReferenceDirectory(testFileLocation)
    let snapshotName = _sanitizedTestName(name)
    let tolerance = tolerance ?? _getTolerance()
    
    let result = sizes.map { (size) -> Bool in
        let view = instance.snapshotObject!
        
        view.removeFromSuperview()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = CGRect(origin: CGPoint.zero, size: size.value)
        view.layoutIfNeeded()
        
        return FBSnapshotTest.compareSnapshot(instance, isDeviceAgnostic: isDeviceAgnostic, usesDrawRect: usesDrawRect, snapshot: "\(snapshotName) - \(size.key)", record: isRecord, referenceDirectory: referenceImageDirectory, tolerance: tolerance)
    }
    
    if isRecord {
        if result.filter({ !$0 }).count == 0 {
            failureMessage.actualValue = "snapshot \(name ?? snapshotName) successfully recorded, replace recordSnapshot with a check"
        } else {
            failureMessage.actualValue = "expected to record a snapshot in \(name)"
        }
        
        return false
    } else {
        if result.filter({ !$0 }).count > 0 {
            _clearFailureMessage(failureMessage)
            failureMessage.actualValue = "expected a matching snapshot in \(snapshotName)"
            return false
        }
        
        return true
    }
}

public func recordSnapshot(_ name: String? = nil, sizes: [String: CGSize]) -> DynamicSizeSnapshot {
    return DynamicSizeSnapshot(name: name, record: true, sizes: sizes)
}

public func recordDynamicSizeSnapshot(named name: String? = nil, sizes: [String: CGSize], usesDrawRect: Bool=false) -> MatcherFunc<Snapshotable> {
    return MatcherFunc { actualExpression, failureMessage in
        return performDynamicSizeSnapshotTest(name, sizes: sizes, usesDrawRect: usesDrawRect, actualExpression: actualExpression, failureMessage: failureMessage, isRecord: true)
    }
}


public func ==(lhs: Expectation<Snapshotable>, rhs: DynamicSizeSnapshot) {
    if rhs.record {
        lhs.to(recordDynamicSizeSnapshot(named: rhs.name, sizes: rhs.sizes))
    } else {
        lhs.to(haveValidDynamicSizeSnapshot(named: rhs.name, sizes: rhs.sizes))
    }
}
