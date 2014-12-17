Pod::Spec.new do |s|
  s.name         = "Nimble-Snapshots"
  s.version      = "0.0.1"
  s.summary      = "Nimble matchers for FBSnapshotTestCase"
  s.description  = <<-DESC
                   Nimble matchers for FBSnapshotTestCase. Highly derivative of Expecta Matchers for FBSnapshotTestCase.
                   DESC
  s.homepage     = "https://github.com/ashfurrow/Nimble-Snapshots"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Ash Furrow" => "ash@ashfurrow.com" }
  s.social_media_url   = "http://twitter.com/ashfurrow"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/ashfurrow/Nimble-Snapshots.git", :commit => "61983ae372c4efb72e9f1f454fa4847c1aa46593" }
  s.source_files  = "HaveValidSnapshot.swift"
  s.frameworks  = "Foundation", "XCTest"
  s.dependency "FBSnapshotTestCase"
  s.dependency "Nimble"
  s.dependency "Quick"
end
