#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint goflutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name                = 'goflutter'
  s.version             = '0.0.1'
  s.summary             = 'A new Flutter plugin project.'
  s.description         = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage            = 'http://example.com'
  s.license             = { :file => '../LICENSE' }
  s.author              = { 'Your Company' => 'email@example.com' }
  s.source              = { :path => '.' }
  s.public_header_files = 'Classes**/*.h'
  s.source_files        = 'Classes/**/*'
  s.vendored_libraries  = "**/*.a"
  s.dependency 'Flutter'
  s.platform            = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version       = '5.0'

#   s.xcconfig = {
#     'OTHER_LDFLAGS[sdk=iphoneos*]' => '$(inherited) -force_load "${PODS_ROOT}/../.symlinks/plugins/goflutter/ios/Classes/libexample.a"',
#     'OTHER_LDFLAGS[sdk=iphonesimulator*]' => '$(inherited) -force_load "${PODS_ROOT}/../.symlinks/plugins/goflutter/ios/Classes/libexample.a"',
#   }
end
