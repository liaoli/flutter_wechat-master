Pod::Spec.new do |s|
  s.name             = 'photo_manager'
  s.version          = '2.0.0'
  s.summary          = 'Photo management APIs for Flutter.'
  s.description      = <<-DESC
A Flutter plugin that provides assets abstraction management APIs.
                       DESC
  s.homepage         = 'https://github.com/fluttercandies/flutter_photo_manager'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'CaiJingLong' => 'cjl_spy@163.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h','Classes/**/**/*.h'
  s.osx.dependency 'FlutterMacOS'
  s.ios.dependency 'Flutter'

  s.ios.framework = 'Photos'
  s.ios.framework = 'PhotosUI'

  s.osx.framework = 'Photos'
  s.osx.framework = 'PhotosUI'

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.15'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
