import Foundation
import UIKit

public final class DynamicTypeView: UIView {
    public let label: UILabel

    public override init(frame: CGRect) {
        label = UILabel()
        super.init(frame: frame)

        backgroundColor = .whiteColor()
        translatesAutoresizingMaskIntoConstraints = false

        label.font = .preferredFontForTextStyle(UIFontTextStyleTitle1)
        label.text = "Example"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .Center
        addSubview(label)

        setNeedsUpdateConstraints()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateFonts),
                                                         name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

    private var createdConstraints = false
    public override func updateConstraints() {
        if !createdConstraints {
            label.leadingAnchor.constraintEqualToAnchor(leadingAnchor).active = true
            label.trailingAnchor.constraintEqualToAnchor(trailingAnchor).active = true
            label.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true
            label.topAnchor.constraintEqualToAnchor(topAnchor).active = true
        }

        super.updateConstraints()
    }

    func updateFonts(notification: NSNotification) {
        guard let category = notification.userInfo?[UIContentSizeCategoryNewValueKey] as? String else {
            return
        }

        print("category is now \(category)")

        label.font = .preferredFontForTextStyle(UIFontTextStyleTitle1)
        label.text = category.stringByReplacingOccurrencesOfString("UICTContentSizeCategory", withString: "")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
