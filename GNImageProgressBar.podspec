Pod::Spec.new do |spec|

  spec.name         = "GNImageProgressBar"
  spec.version      = "0.1.0"
  spec.summary      = "Show progress with an image."
  spec.description  = <<-DESC
  Show progress with an image.
                   DESC
  spec.homepage     = "https://github.com/nicolaouG/GNImageProgressBar"
  spec.screenshots  = "https://github.com/nicolaouG/GNImageProgressBar/blob/master/imageProgress.gif"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "george" => "ch.nicolaou61@hotmail.com" }
  spec.platform     = :ios
  spec.ios.deployment_target = "10.0"
  spec.swift_version = "5"
  spec.source       = { :git => "https://github.com/nicolaouG/GNImageProgressBar.git", :tag => "#{spec.version}" }
  spec.source_files = "GNImageProgressBar/**/*.{h,m,swift}"
  spec.resources    = "GNImageProgressBar/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
  spec.framework    = "UIKit"
  spec.requires_arc = true

end
