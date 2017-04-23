Pod::Spec.new do |s|
  s.name         = "Nimble-Snapshots"
  s.version      = "4.4.2"
  s.summary      = "Nimble matchers for FBSnapshotTestCase"
  s.description  = <<-DESC
                   Nimble matchers for FBSnapshotTestCase. Highly derivative of [Expecta Matchers for FBSnapshotTestCase](https://github.com/dblock/ios-snapshot-test-case-expecta).
                   DESC
  s.homepage     = "https://github.com/ashfurrow/Nimble-Snapshots"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Ash Furrow" => "ash@ashfurrow.com" }
  s.social_media_url   = "http://twitter.com/ashfurrow"
  s.platform     = :ios, "8.0"
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
  s.source       = { :git => "https://github.com/ashfurrow/Nimble-Snapshots.git", :tag => s.version }
  s.default_subspec = "Core"
  s.frameworks  = "Foundation", "XCTest"

  s.subspec "Core" do |ss|
    ss.source_files  = "HaveValidSnapshot.swift", "PrettySyntax.swift", "NimbleSnapshotsConfiguration.swift", "XCTestObservationCenter+CurrentTestCaseTracker.{h,m}"
    ss.dependency "FBSnapshotTestCase", "~> 2.0"
    ss.dependency "Nimble"
    ss.dependency "Quick"
  end

  s.subspec "DynamicType" do |ss|
    ss.source_files  = "DynamicType/*.{swift,m,h}"
    ss.frameworks = "UIKit"

    ss.dependency "Nimble-Snapshots/Core"
    ss.dependency "OCMock", "~> 3.3"
  end

  s.subspec "DynamicSize" do |ss|
    ss.source_files  = "DynamicSize/*.{swift}"
    ss.frameworks = "UIKit"

    ss.dependency "Nimble-Snapshots/Core"
  end
end
