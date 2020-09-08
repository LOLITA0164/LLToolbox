#
# Be sure to run `pod lib lint LLToolbox.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LLToolbox'
  s.version          = '0.2.8'
  s.summary          = '开发工具盒.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/LOLITA0164/LLToolbox'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LOLITA0164' => '476512340@qq.com' }
  s.source           = { :git => 'https://github.com/LOLITA0164/LLToolbox.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'LLToolbox/Classes/*.h'
  # 层级目录，添加公共头文件
  s.public_header_files = 'LLToolbox/Classes/*.h'
  
#  s.vendored_frameworks = 'LLToolbox/Frameworks/LLToolbox.framework'
  
  s.subspec 'Categorys' do |ss|
    ss.source_files = 'LLToolbox/Classes/Categorys/*'
  end

  s.subspec 'Functions' do |dd|
    dd.source_files = 'LLToolbox/Classes/Functions/*'
  end

  s.subspec 'Views' do |aa|
    aa.source_files = 'LLToolbox/Classes/Views/*'
    aa.dependency 'LLToolbox/Categorys'
  end
  
  
  # s.resource_bundles = {
  #   'LLToolbox' => ['LLToolbox/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
