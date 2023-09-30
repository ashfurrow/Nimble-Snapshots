namespace :build do
  desc 'Build package'
  namespace :package do
    desc 'Build the Nimble-Snapshots package'
    task all: ['iOS']
    
    desc 'Build the Nimble-Snapshots package for iOS'
    task :iOS do
      xcodebuild('build -scheme Nimble-Snapshots -destination "platform=iOS Simulator,name=iPhone 14"')
    end
  end
end
