Pod::Spec.new do |s|
  s.name         = "DWLaunchScreen"
  s.version      = "0.0.1"
  s.summary      = "启动页."
  s.description  = <<-DESC
  使用网页,图片作为启动页
                   DESC

  s.homepage     = "https://github.com/dwanghello/DWLaunchScreen"
  s.license      = "MIT"
  s.author             = { "dwanghello" => "dwang.hello@outlook.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/dwanghello/DWLaunchScreen.git", :tag => "#{s.version}" }
  s.source_files  = "DWLaunchScreen", "DWLaunchScreen/**/*.{h,m}"
  s.frameworks = "ImageIO", "Foundation", "UIKit"
end
