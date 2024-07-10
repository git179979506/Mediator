#
# Be sure to run `pod lib lint Mediator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Mediator'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Mediator.'
  s.description      = 'A long description of Mediator.'

  s.homepage         = 'https://github.com/zhaoshouwen/Mediator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhaoshouwen' => 'zsw19911017@163.com' }
  s.source           = { :git => 'https://github.com/zhaoshouwen/Mediator.git', :tag => s.version.to_s }
  s.social_media_url = 'https://juejin.cn/user/4265760847569166'

  s.ios.deployment_target = '10.0'
  s.swift_versions = ['4.2', '5.0']

  s.source_files = 'Mediator/Classes/**/*'
  
end
