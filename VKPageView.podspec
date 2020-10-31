Pod::Spec.new do |s|
  s.name         = 'VKPageView'
  s.version      = '1.1.0'
  s.license = 'MIT'
  s.requires_arc = true
  s.source = { :git => 'https://github.com/vicgillx/VKPageView.git', :tag => s.version.to_s }

  s.summary         = 'swift版本的pageView'
  s.homepage        = 'https://github.com/vicgillx/VKPageView'
  s.license         = { :type => 'MIT',:file =>'LICENSE' }
  s.author          = { 'karl' => 'vicgil@gmail.com' }
  s.platform        = :ios
  s.swift_version   = '5.0'
  s.source_files    =  'Sources/*'
  s.ios.deployment_target = '10.0'
  s.exclude_files = "Sources/*.plist"

  
end
