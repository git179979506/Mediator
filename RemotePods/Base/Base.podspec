
Pod::Spec.new do |s|
  s.name             = 'Base'
  s.version          = '0.1.0'
  s.summary          = 'Base Module'

  s.description      = '基础组件'

  s.homepage         = 'https://github.com/git179979506/TableViewSections'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhaoshouwen' => 'zsw19911017@163.com' }
  s.source           = { :git => 'https://github.com/git179979506/TableViewSections.git', :tag => s.version.to_s }
  s.social_media_url = 'https://juejin.cn/user/4265760847569166'
  s.swift_versions = ['4.2', '5.0']

  s.ios.deployment_target = '12.0'

  s.source_files = 'Classes/**/*'
  s.resource_bundles = { 'Base' => ['Assets/Images.xcassets'] }

  
  s.dependency 'SnapKit', '~> 5.7.0'
  s.dependency 'PageState', '0.2.0'
  s.dependency 'TableViewSections', '0.1.0'
  
end
