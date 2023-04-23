import Nimble
import UIKit

// MARK: - Nicer syntax using == operator

public struct Snapshot {
    let name: String?
    let identifier: String?
    let record: Bool
    let usesDrawRect: Bool
    let userInterfaceStyle: UIUserInterfaceStyle?

    init(name: String?, identifier: String?, record: Bool, usesDrawRect: Bool, userInterfaceStyle: UIUserInterfaceStyle?) {
        self.name = name
        self.identifier = identifier
        self.record = record
        self.usesDrawRect = usesDrawRect
        self.userInterfaceStyle = userInterfaceStyle
    }
}

public func snapshot(_ name: String? = nil,
                     identifier: String? = nil,
                     usesDrawRect: Bool = false,
                     userInterfaceStyle: UIUserInterfaceStyle? = nil) -> Snapshot {
    return Snapshot(name: name, identifier: identifier, record: false, usesDrawRect: usesDrawRect, userInterfaceStyle: userInterfaceStyle)
}

public func recordSnapshot(_ name: String? = nil,
                           identifier: String? = nil,
                           usesDrawRect: Bool = false,
                           userInterfaceStyle: UIUserInterfaceStyle? = nil) -> Snapshot {
    return Snapshot(name: name, identifier: identifier, record: true, usesDrawRect: usesDrawRect, userInterfaceStyle: userInterfaceStyle)
}

public func ==(lhs: Nimble.SyncExpectation<Snapshotable>, rhs: Snapshot) {
    if rhs.record {
        lhs.to(recordSnapshot(named: rhs.name,
                              identifier: rhs.identifier,
                              usesDrawRect: rhs.usesDrawRect,
                              userInterfaceStyle: rhs.userInterfaceStyle))
    } else {
        lhs.to(haveValidSnapshot(named: rhs.name,
                                 identifier: rhs.identifier,
                                 usesDrawRect: rhs.usesDrawRect,
                                 userInterfaceStyle: rhs.userInterfaceStyle))
    }
}

public func ==(lhs: Nimble.AsyncExpectation<Snapshotable>, rhs: Snapshot) async {
    if rhs.record {
        await lhs.to(recordSnapshot(named: rhs.name, identifier: rhs.identifier, usesDrawRect: rhs.usesDrawRect))
    } else {
        await lhs.to(haveValidSnapshot(named: rhs.name, identifier: rhs.identifier, usesDrawRect: rhs.usesDrawRect))
    }
}

// MARK: - Nicer syntax using emoji

// swiftlint:disable:next identifier_name
public func 📷(_ file: FileString = #file, line: UInt = #line, snapshottable: Snapshotable) {
  expect(file: file, line: line, snapshottable).to(recordSnapshot())
}

// swiftlint:disable:next identifier_name
public func 📷(_ name: String, file: FileString = #file, line: UInt = #line, snapshottable: Snapshotable) {
  expect(file: file, line: line, snapshottable).to(recordSnapshot(named: name))
}
