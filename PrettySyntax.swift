import Nimble

// MARK: - Nicer syntax using == operator

public struct Snapshot {
    let name: String?
    let file: FileString
    let line: UInt

    init(name: String?, file: FileString, line: UInt) {
        self.name = name
        self.file = file
        self.line = line
    }
}

public func snapshot(name: String? = nil, file: FileString = #file, line: UInt = #line) -> Snapshot {
    return Snapshot(name: name, file: file, line: line)
}

public func ==(lhs: Expectation<Snapshotable>, rhs: Snapshot) {
    if let name = rhs.name {
        lhs.to(haveValidSnapshot(named: name))
    } else {
        lhs.to(haveValidSnapshot())
    }
}

// MARK: - Nicer syntax using emoji

public func 📷(snapshottable: Snapshotable, file: FileString = #file, line: UInt = #line) {
    expect(snapshottable, file: file, line: line).to(recordSnapshot())
}

public func 📷(snapshottable: Snapshotable, named name: String, file: FileString = #file, line: UInt = #line) {
    expect(snapshottable, file: file, line: line).to(recordSnapshot(named: name))
}
