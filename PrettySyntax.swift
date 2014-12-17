import Nimble

// MARK: - Nicer syntax using == operator

public struct Snapshot {
    let name: String

    init(name: String) {
        self.name = name
    }
}

public func snapshot(name: String) -> Snapshot {
    return Snapshot(name: name)
}

public func ==(lhs: Expectation<Snapshotable>, rhs: Snapshot) {
    lhs.to(haveValidSnapshot(named: rhs.name))
}

// MARK: - Nicer syntax using emoji

public func 📷(snapshottable: Snapshotable) {
    expect(snapshottable).to(recordSnapshot())
}
