Pod::Spec.new do |s|
  s.name         = "Nimble-Snapshots"
  s.version      = "4.0.0"
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
  s.source_files  = "HaveValidSnapshot.swift", "PrettySyntax.swift", "NimbleSnapshotsConfiguration.swift"
  s.frameworks  = "Foundation", "XCTest"
  s.dependency "FBSnapshotTestCase", "~> 2.0"
  s.dependency "Nimble"
  s.dependency "Quick"
end
