namespace :test do
  task :default do
    sh "xcodebuild -destination 'OS=latest,name=iPhone 5s,platform=iOS Simulator' -workspace Numeric.xcworkspace -scheme numeric test | xcpretty -c"
  end

  task :ci do
    sh "xcodebuild -destination 'OS=latest,name=iPhone 5s,platform=iOS Simulator' -workspace Numeric.xcworkspace -scheme numeric test"
  end
end

task :test => "test:default"
task :default => :test
