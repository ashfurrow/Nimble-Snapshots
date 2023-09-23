build-ios:
	set -o pipefail && \
	xcodebuild build \
		-scheme DataLife \
		-destination "platform=iOS Simulator,name=IPhone 14" | xcpretty

build-tvos:
	set -o pipefail && \
	xcodebuild build \
		-scheme DataLife \
		-destination platform="tvOS Simulator,name=Apple TV 4K" | xcpretty
