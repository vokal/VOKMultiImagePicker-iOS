#
# Be sure to run `pod lib lint VOKMultiImagePicker-iOS.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "VOKMultiImagePicker-iOS"
  s.version          = "0.1.0"
  s.summary          = "A multiple image picker using PhotoKit."
  s.description      = <<-DESC
                       DESC
  s.homepage         = "https://github.com/vokalinteractive/VOKMultiImagePicker-iOS"
  s.license          = 'MIT'
  s.author           = { "Luke" => "luke.quigley@vokalinteractive.com" }
  s.source           = { :git => "https://github.com/vokalinteractive/VOKMultiImagePicker-iOS.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{h,m}'
  s.resource_bundles = {
      'VOKMultiImagePicker-iOS' => ['Pod/Assets/*.{png,xib,storyboard}']
  }

  s.frameworks = 'UIKit', 'Photos'
end
