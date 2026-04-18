import Nimble_Snapshots
#if canImport(SwiftUI)
    import SwiftUI

    // Verify SnapshotSize is in scope — this was the failing type in issue #302
    func _verifySnapshotSizeCompiles() {
        let _: SnapshotSize = .device
        let _: SnapshotSize = .fixed(.zero)
        let _: SnapshotSize = .intrinsic
    }
#endif
