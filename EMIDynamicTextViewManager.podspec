Pod::Spec.new do |s|
  s.name             = "EMIDynamicTextViewManager"
  s.version          = "0.1.0"
  s.summary          = "Manager to extend textview capabilities"
  s.homepage         = "https://github.com/ibnusina/EMIDynamicTextViewManager"
  s.license          = 'MIT'
  s.author           = { "Ibnu Sina" => "ibnu.sina009@gmail.com" }
  s.source           = { :git => "https://github.com/ibnusina/EMIDynamicTextViewManager.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  s.dependency 'ReactiveCocoa', '2.3.1'
end
