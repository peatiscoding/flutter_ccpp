#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_ccpp.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_ccpp'
  s.version          = '0.0.1'
  s.summary          = 'A flutter plugin for 2c2p lib.'
  s.description      = 'A flutter plugin for 2c2p lib.'
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'peatiscoding' => 'freeuxer@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386'
  }
  s.vendored_frameworks = "Vendors/PGW.framework"
  s.swift_version = '5.0'
end
