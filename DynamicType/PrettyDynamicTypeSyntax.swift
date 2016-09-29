import Nimble

// MARK: - Nicer syntax using == operator

public struct DynamicTypeSnapshot {
    let name: String?
    let record: Bool
    let sizes: [UIContentSizeCategory]

    init(name: String?, record: Bool, sizes: [UIContentSizeCategory]) {
        self.name = name
        self.record = record
        self.sizes = sizes
    }
}

public func dynamicTypeSnapshot(_ name: String? = nil, sizes: [UIContentSizeCategory] = allContentSizeCategories()) -> DynamicTypeSnapshot {
    return DynamicTypeSnapshot(name: name, record: false, sizes: sizes)
}

public func recordDynamicTypeSnapshot(_ name: String? = nil, sizes: [UIContentSizeCategory] = allContentSizeCategories()) -> DynamicTypeSnapshot {
    return DynamicTypeSnapshot(name: name, record: true, sizes: sizes)
}

public func ==(lhs: Expectation<Snapshotable>, rhs: DynamicTypeSnapshot) {
    if let name = rhs.name {
        if rhs.record {
            lhs.to(recordDynamicTypeSnapshot(named: name, sizes: rhs.sizes))
        } else {
            lhs.to(haveValidDynamicTypeSnapshot(named: name, sizes: rhs.sizes))
        }

    } else {
        if rhs.record {
            lhs.to(recordDynamicTypeSnapshot(sizes: rhs.sizes))
        } else {
            lhs.to(haveValidDynamicTypeSnapshot(sizes: rhs.sizes))
        }
    }
}
