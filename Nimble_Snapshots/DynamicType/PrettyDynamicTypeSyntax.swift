import Nimble
import UIKit

// MARK: - Nicer syntax using == operator

public struct DynamicTypeSnapshot {
    let name: String?
    let identifier: String?
    let record: Bool
    let sizes: [UIContentSizeCategory]
    let deviceAgnostic: Bool
    let userInterfaceStyle: UIUserInterfaceStyle?

    init(name: String?,
         identifier: String?,
         record: Bool,
         sizes: [UIContentSizeCategory],
         deviceAgnostic: Bool,
         userInterfaceStyle: UIUserInterfaceStyle?) {
        self.name = name
        self.identifier = identifier
        self.record = record
        self.sizes = sizes
        self.deviceAgnostic = deviceAgnostic
        self.userInterfaceStyle = userInterfaceStyle
    }
}

public func dynamicTypeSnapshot(_ name: String? = nil,
                                identifier: String? = nil,
                                sizes: [UIContentSizeCategory] = allContentSizeCategories(),
                                deviceAgnostic: Bool = false,
                                userInterfaceStyle: UIUserInterfaceStyle? = nil) -> DynamicTypeSnapshot {
    return DynamicTypeSnapshot(name: name,
                               identifier: identifier,
                               record: false,
                               sizes: sizes,
                               deviceAgnostic: deviceAgnostic,
                               userInterfaceStyle: userInterfaceStyle)
}

public func recordDynamicTypeSnapshot(_ name: String? = nil,
                                      identifier: String? = nil,
                                      sizes: [UIContentSizeCategory] = allContentSizeCategories(),
                                      deviceAgnostic: Bool = false,
                                      userInterfaceStyle: UIUserInterfaceStyle? = nil) -> DynamicTypeSnapshot {
    return DynamicTypeSnapshot(name: name,
                               identifier: identifier,
                               record: true,
                               sizes: sizes,
                               deviceAgnostic: deviceAgnostic,
                               userInterfaceStyle: userInterfaceStyle)
}

public func ==<Expectation: Nimble.Expectation>(lhs: Expectation, rhs: DynamicTypeSnapshot) where Expectation.Value: Snapshotable {
    if let name = rhs.name {
        if rhs.record {
            lhs.to(recordDynamicTypeSnapshot(named: name,
                                             sizes: rhs.sizes,
                                             isDeviceAgnostic: rhs.deviceAgnostic,
                                             userInterfaceStyle: rhs.userInterfaceStyle))
        } else {
            lhs.to(haveValidDynamicTypeSnapshot(named: name,
                                                sizes: rhs.sizes,
                                                isDeviceAgnostic: rhs.deviceAgnostic,
                                                userInterfaceStyle: rhs.userInterfaceStyle))
        }

    } else {
        if rhs.record {
            lhs.to(recordDynamicTypeSnapshot(sizes: rhs.sizes,
                                             isDeviceAgnostic: rhs.deviceAgnostic,
                                             userInterfaceStyle: rhs.userInterfaceStyle))
        } else {
            lhs.to(haveValidDynamicTypeSnapshot(sizes: rhs.sizes,
                                                isDeviceAgnostic: rhs.deviceAgnostic,
                                                userInterfaceStyle: rhs.userInterfaceStyle))
        }
    }
}
