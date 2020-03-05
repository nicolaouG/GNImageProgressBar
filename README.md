# GNImageProgressBar

<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift5.0-compatible-4BC51D.svg?style=flat" alt="Swift 5.0 compatible" /></a>
<a href="https://github.com/nicolaouG/GNImageProgressBar/blob/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License: MIT" /></a>

Show progress with an image.

![](imageProgress.gif)


## Getting started
```
platform :ios, '10.0'

pod 'GNImageProgressBar'
```

## How to use

You can have a look at the demo project for a simple use case (ExampleViewController).

Currently, only one fill direction is supported:
```swift
let imageProgressBar = GNImageProgressBar(image: myImage, size: desiredSize, backgroundImageAlpha: myAlpha, shouldShowBackgroundImage: true, fillDirection: .fromBottom, progress: 0.3)
```
or just
```swift
let imageProgressBar = GNImageProgressBar(image: myImage, size: desiredSize, fillDirection: .fromBottom)

// view.addSubview(imageProgressBar)
// setup constraints or frame

imageProgressBar.setProgress(progress, animated: true)
```


