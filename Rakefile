require 'tmpdir'

desc 'Run unit tests on iOS 9.3 and 10.3'
task :test do
  # workaround for https://github.com/travis-ci/travis-ci/issues/7638
  sh "xcrun simctl create 'iPhone 6' com.apple.CoreSimulator.SimDeviceType.iPhone-6 com.apple.CoreSimulator.SimRuntime.iOS-9-3"

  sh "set -o pipefail && xcodebuild -workspace 'Bootstrap/Bootstrap.xcworkspace' -sdk 'iphonesimulator' -scheme 'Bootstrap' -destination 'name=iPhone 6,OS=9.3' -destination 'name=iPhone 6,OS=10.3' clean build test | xcpretty --color --simple"
end

desc 'Lint the library for CocoaPods usage'
task :pod_lint do
  sh 'bundle exec pod lib lint --allow-warnings'
end

desc 'Run a local copy of Carthage on a temporary directory'
task :carthage do
  # make a folder, put a cartfile in and make it a consumer
  # of the root dir

  repo_dir = Dir.pwd
  Dir.mktmpdir('carthage_test') do |dir|
    Dir.chdir dir do
      File.write('Cartfile', "git \"file://#{repo_dir}\" \"HEAD\"")

      sh "carthage bootstrap --platform 'iOS'"
      has_artifacts = !Dir.glob("Carthage/Build/*").empty?
      raise("Carthage did not succeed") unless has_artifacts
    end
  end
end

desc 'Runs SwiftLint'
task :swiftlint do
  sh 'swiftlint lint --no-cache'
end
