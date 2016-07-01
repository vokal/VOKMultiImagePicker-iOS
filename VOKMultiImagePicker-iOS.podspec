Pod::Spec.new do |s|
  s.name             = "VOKMultiImagePicker-iOS"
  s.version          = "1.0.0"
  s.summary          = "A multiple image picker using Photos framework."
  s.description      = "A customizable library for selecting assets from the built in Photos app using the Photos framework."
  s.homepage         = "https://github.com/vokalinteractive/VOKMultiImagePicker-iOS"
  s.license          = 'MIT'
  s.author           = { "Vokal" => "ios@vokal.io" }
  s.source           = { :git => "https://github.com/vokalinteractive/VOKMultiImagePicker-iOS.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.3'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{h,m}'

  s.frameworks = 'UIKit', 'Photos'
end
