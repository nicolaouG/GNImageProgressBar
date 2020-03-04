Pod::Spec.new do |spec|

  spec.name         = "GNImageProgressBar"
  spec.version      = "0.1.2"
  spec.summary      = "Show progress with an image."
  spec.description  = <<-DESC
  This library can be used to show progress by filling an image.
                   DESC
  spec.homepage     = "https://github.com/nicolaouG/GNImageProgressBar"
  spec.screenshots  = "https://raw.githubusercontent.com/nicolaouG/GNImageProgressBar/master/imageProgress.gif"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "george" => "georgios.nicolaou92@gmail.com" }
  spec.platform     = :ios
  spec.ios.deployment_target = "10.0"
  spec.swift_version = "5"
  spec.source       = { :git => "https://github.com/nicolaouG/GNImageProgressBar.git", :tag => "#{spec.version}" }
  spec.source_files = "GNImageProgressBar/**/*.{h,m,swift}"
  spec.framework    = "UIKit"
  spec.requires_arc = true

end
