require 'tmpdir'

desc 'Run unit tests on iOS 9.3 and 10.2'
task :test do
  sh "set -o pipefail && xcodebuild -workspace 'Bootstrap/Bootstrap.xcworkspace' -sdk 'iphonesimulator' -scheme 'Bootstrap' -destination 'name=iPhone 6,OS=9.3' -destination 'platform=iOS Simulator,id=1FD54EA7-5A25-4D6F-8599-D6F7687DA4EE,OS=10.2' clean build test | xcpretty --color --simple"
end

desc 'Lint the library for CocoaPods usage'
task :pod_lint do
  sh 'bundle exec pod lib lint'
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

desc 'Runs SwiftLint'
task :swiftlint do
  sh 'swiftlint lint --no-cache'
end
