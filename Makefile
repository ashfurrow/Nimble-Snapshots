build-ios:
	set -o pipefail && \
	xcodebuild build \
		-scheme Nimble-Snapshots \
		-destination "platform=iOS Simulator,name=IPhone 14" | xcpretty

build-tvos:
	set -o pipefail && \
	xcodebuild build \
		-scheme Nimble-Snapshots \
		-destination platform="tvOS Simulator,name=Apple TV 4K" | xcpretty
