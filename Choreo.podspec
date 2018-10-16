Pod::Spec.new do |s|
  s.name             = 'Choreo'
  s.version          = '1.0.0'
  s.summary          = 'Choreograph animations between different UIViews'
  s.description      = <<-DESC
  Enables multiple views to be animated in unison. Just specify a duration for the entire animation and 
  Choreo will calculate the durations and start time for any subanimations you've defined. 
                       DESC

  s.homepage         = 'https://github.com/tylerc230/Choreo'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tyler Casselman' => 'tyler@13bit.io' }
  s.source           = { :git => 'https://github.com/Tyler Casselman/Choreo.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_version = '4'

  s.source_files = 'Choreo/Classes/**/*'
end
