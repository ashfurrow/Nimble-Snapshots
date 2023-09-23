build-ios:
	set -o pipefail && \
	xcodebuild build \
		-scheme Nimble-Snapshots \
		-destination "platform=iOS Simulator,name=IPhone 14" | xcpretty
