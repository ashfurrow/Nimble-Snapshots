import Foundation
import FBSnapshotTestCase
import UIKit
import Nimble
import QuartzCore
import Quick

public enum ResizeMode {
    case frame
    case constrains
    case block(resizeBlock: (UIView, CGSize)->())
    case custom(ViewResizer: ViewResizer)
    
    func viewResizer() -> ViewResizer {
        switch self {
        case .frame:
            return FrameViewResizer()
            
        case .constrains:
            return ConstraintViewResizer()
            
        case .block(resizeBlock: let block):
            return BlockViewResizer(block: block)
            
        case .custom(ViewResizer: let resizer):
            return resizer
        }
    }
}

public protocol ViewResizer {
    func resize(view view: UIView, for size: CGSize)
}


struct FrameViewResizer: ViewResizer {
    func resize(view view: UIView, for size: CGSize) {
        view.frame = CGRect(origin: CGPoint.zero, size: size)
        view.layoutIfNeeded()
    }
}

struct BlockViewResizer: ViewResizer {
    
    let resizeBlock: (UIView, CGSize) -> Void

    init(block: @escaping (UIView, CGSize) -> Void) {
        self.resizeBlock = block
    }

    func resize(view view: UIView, for size: CGSize) {
        self.resizeBlock(view, size)
    }
}

class ConstraintViewResizer: ViewResizer {
    
    typealias SizeConstrainsWrapper = (heightConstrain: NSLayoutConstraint, widthConstrain: NSLayoutConstraint)
    
    func resize(view view: UIView, for size: CGSize) {
        let sizesConstrains = findConstrains(of: view)
        
        sizesConstrains.heightConstrain.constant = size.height
        sizesConstrains.widthConstrain.constant = size.width

        NSLayoutConstraint.activate([sizesConstrains.heightConstrain,
                                     sizesConstrains.widthConstrain])
        

        view.layoutIfNeeded()

        //iOS 9+ BUG: Before the first draw, iOS will not calculate the layout, it add a _UITemporaryLayoutWidth equals to 
        // its bounds and create a conflict. So to it do all the layout we create a Window and add it as subview
        if view.bounds.width != size.width || view.bounds.width != size.width {
            let window = UIWindow(frame: CGRect(origin: CGPoint.zero, size: size))
            let viewController = UIViewController()
            viewController.view = UIView()
            viewController.view.addSubview(view)
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            view.setNeedsLayout()
            view.layoutIfNeeded()
        }
    }
    
    func findConstrains(of view: UIView) -> SizeConstrainsWrapper {
        var height: NSLayoutConstraint?
        var width: NSLayoutConstraint?

        var heightLayout = NSLayoutAttribute.height
        var widthLayout = NSLayoutAttribute.width
        var equalRelation = NSLayoutRelation.equal
        
        for constrain in view.constraints {
            if constrain.firstAttribute.rawValue == heightLayout.rawValue && constrain.relation.rawValue == equalRelation.rawValue && constrain.secondItem == nil {
                height = constrain
            }
            
            if constrain.firstAttribute.rawValue == widthLayout.rawValue && constrain.relation.rawValue == equalRelation.rawValue && constrain.secondItem == nil {
                width = constrain
            }
        }
        
        if height == nil {
            height = NSLayoutConstraint(item: view, attribute: heightLayout, relatedBy: equalRelation, toItem: nil, attribute: heightLayout, multiplier: 1, constant: 0)
            view.addConstraint(height!)
        }
        
        if width == nil {
            width = NSLayoutConstraint(item: view, attribute: widthLayout, relatedBy: equalRelation, toItem: nil, attribute: widthLayout, multiplier: 1, constant: 0)
            view.addConstraint(width!)
        }
        
        return (height!, width!)
    }
}



public struct DynamicSizeSnapshot {
    let name: String?
    let record: Bool
    let sizes: [String: CGSize]
    let resizeMode: ResizeMode
    
    init(name: String?, record: Bool, sizes: [String: CGSize], resizeMode: ResizeMode) {
        self.name = name
        self.record = record
        self.sizes = sizes
        self.resizeMode = resizeMode
    }
}

public func snapshot(_ name: String? = nil, sizes: [String: CGSize], resizeMode: ResizeMode = .frame) -> DynamicSizeSnapshot {
    return DynamicSizeSnapshot(name: name, record: false, sizes: sizes, resizeMode: resizeMode)
}

public func haveValidDynamicSizeSnapshot(named name: String? = nil, sizes: [String: CGSize], usesDrawRect: Bool=false, tolerance: CGFloat? = nil, resizeMode: ResizeMode = .frame) -> MatcherFunc<Snapshotable> {
    return MatcherFunc { actualExpression, failureMessage in
        return performDynamicSizeSnapshotTest(name, sizes: sizes, usesDrawRect: usesDrawRect, actualExpression: actualExpression, failureMessage: failureMessage, tolerance: tolerance, isRecord: false, resizeMode: resizeMode)
    }
}

func performDynamicSizeSnapshotTest(_ name: String?, sizes: [String: CGSize], isDeviceAgnostic: Bool=false, usesDrawRect: Bool=false, actualExpression: Expression<Snapshotable>, failureMessage: FailureMessage, tolerance: CGFloat? = nil, isRecord: Bool, resizeMode: ResizeMode) -> Bool {
    let instance = try! actualExpression.evaluate()!
    let testFileLocation = actualExpression.location.file
    let referenceImageDirectory = _getDefaultReferenceDirectory(testFileLocation)
    let snapshotName = _sanitizedTestName(name)
    let tolerance = tolerance ?? _getTolerance()
    
    let resizer = resizeMode.viewResizer()
    
    let result = sizes.map { (sizeName, size) -> Bool in
        let view = instance.snapshotObject!
        
        resizer.resize(view: view, for: size)
        
        return FBSnapshotTest.compareSnapshot(instance, isDeviceAgnostic: isDeviceAgnostic, usesDrawRect: usesDrawRect, snapshot: "\(snapshotName) - \(sizeName)", record: isRecord, referenceDirectory: referenceImageDirectory, tolerance: tolerance)
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

public func recordSnapshot(_ name: String? = nil, sizes: [String: CGSize], resizeMode: ResizeMode = .frame) -> DynamicSizeSnapshot {
    return DynamicSizeSnapshot(name: name, record: true, sizes: sizes, resizeMode: resizeMode)
}

public func recordDynamicSizeSnapshot(named name: String? = nil, sizes: [String: CGSize], usesDrawRect: Bool=false, resizeMode: ResizeMode = .frame) -> MatcherFunc<Snapshotable> {
    return MatcherFunc { actualExpression, failureMessage in
        return performDynamicSizeSnapshotTest(name, sizes: sizes, usesDrawRect: usesDrawRect, actualExpression: actualExpression, failureMessage: failureMessage, isRecord: true, resizeMode: resizeMode)
    }
}


public func ==(lhs: Expectation<Snapshotable>, rhs: DynamicSizeSnapshot) {
    if rhs.record {
        lhs.to(recordDynamicSizeSnapshot(named: rhs.name, sizes: rhs.sizes, resizeMode: rhs.resizeMode))
    } else {
        lhs.to(haveValidDynamicSizeSnapshot(named: rhs.name, sizes: rhs.sizes, resizeMode: rhs.resizeMode))
    }
}

