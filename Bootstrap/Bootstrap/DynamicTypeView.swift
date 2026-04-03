import Foundation
import UIKit

public final class DynamicTypeView: UIView {
    public let label: UILabel

    override public init(frame: CGRect) {
        label = UILabel()
        super.init(frame: frame)

        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false

        label.font = .preferredFont(forTextStyle: .body)
        label.text = "Example"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        addSubview(label)

        setNeedsUpdateConstraints()

        NotificationCenter.default.addObserver(self, selector: #selector(updateFonts),
                                               name: UIContentSizeCategory.didChangeNotification,
                                               object: nil)
    }

    private var createdConstraints = false
    override public func updateConstraints() {
        if !createdConstraints {
            label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        }

        super.updateConstraints()
    }

    @objc
    func updateFonts(_ notification: Notification) {
        guard let category = notification.userInfo?[UIContentSizeCategory.newValueUserInfoKey] as? String else {
            return
        }

        label.font = .preferredFont(forTextStyle: .body)
        label.text = category.replacingOccurrences(of: "UICTContentSizeCategory", with: "")
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
