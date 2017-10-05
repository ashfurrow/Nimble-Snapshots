Pod::Spec.new do |s|
  s.name         = "Nimble-Snapshots"
  s.version      = "6.3.0"
  s.summary      = "Nimble matchers for FBSnapshotTestCase"
  s.description  = <<-DESC
                   Nimble matchers for FBSnapshotTestCase. Highly derivative of [Expecta Matchers for FBSnapshotTestCase](https://github.com/dblock/ios-snapshot-test-case-expecta).
                   DESC
  s.homepage     = "https://github.com/ashfurrow/Nimble-Snapshots"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Ash Furrow" => "ash@ashfurrow.com" }
  s.social_media_url   = "http://twitter.com/ashfurrow"
  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.0"
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
  s.source       = { :git => "https://github.com/ashfurrow/Nimble-Snapshots.git", :tag => s.version }
  s.default_subspec = "Core"
  s.frameworks  = "Foundation", "XCTest", "UIKit"

  s.subspec "Core" do |ss|
    ss.source_files  = "*.{h,m,swift}", "DynamicType/*.{swift,m,h}", "DynamicSize/*.{swift}"
    ss.dependency "FBSnapshotTestCase", "~> 2.0"
    ss.dependency "Nimble", "~> 7.0"
  end

  # for compatibiliy reasons
  s.subspec "DynamicType" do |ss|
    ss.dependency "Nimble-Snapshots/Core"
  end

  s.subspec "DynamicSize" do |ss|
    ss.dependency "Nimble-Snapshots/Core"
  end
end
