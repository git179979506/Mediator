
Pod::Spec.new do |s|
  s.name             = 'Community'
  s.version          = '0.1.0'
  s.summary          = 'Community Module'

  s.description      = '社区业务组件'

  s.homepage         = 'https://github.com/git179979506/TableViewSections'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhaoshouwen' => 'zsw19911017@163.com' }
  s.source           = { :git => 'https://github.com/git179979506/TableViewSections.git', :tag => s.version.to_s }
  s.social_media_url = 'https://juejin.cn/user/4265760847569166'
  s.swift_versions = ['4.2', '5.0']

  s.ios.deployment_target = '12.0'

  s.source_files = 'Community/Classes/**/*'
  s.resource_bundles = { 'Community' => 'Community/Assets/**/*' }
  
  s.dependency 'Base'
  s.dependency 'CommunityInterface'
end
