//
//  GNImageProgressBar.swift
//  GNImageProgressBar
//
//  Created by george on 03/03/2020.
//  Copyright © 2020 George Nicolaou. All rights reserved.
//

import UIKit

public class GNImageProgressBar: UIView {
    public enum FillDirection {
        case fromBottom
    }
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .center
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
        
    private lazy var trackImageView: UIImageView = {
        let iv = UIImageView()
        switch fillDirection {
        case .fromBottom:
            iv.contentMode = .bottom
        }
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var trackIvHeightConstraint = NSLayoutConstraint(item: trackImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
    
    public var image: UIImage
    public var size: CGSize
    public var shouldShowBackgroundImage: Bool
    public var backgroundImageAlpha: CGFloat
    public var fillDirection: FillDirection
    public var progress: CGFloat
    
    public var fixedSize: CGSize = .zero
    
    
    public init(image: UIImage, size: CGSize, backgroundImageAlpha: CGFloat = 0.4, shouldShowBackgroundImage: Bool = true, fillDirection: FillDirection, progress: CGFloat = 0) {
        self.image = image
        self.size = size
        self.shouldShowBackgroundImage = shouldShowBackgroundImage
        self.backgroundImageAlpha = shouldShowBackgroundImage ? backgroundImageAlpha : 0
        self.fillDirection = fillDirection
        self.progress = progress
        
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        /// initial constraints
        if trackImageView.frame == .zero {
            trackImageView.translatesAutoresizingMaskIntoConstraints = false
            setProgress(progress, animated: false)
        }
    }
    
    
    private func setup() {
        backgroundImageView.alpha = backgroundImageAlpha
        
        addSubview(backgroundImageView)
        addSubview(trackImageView)
        
        setupImageViews()
        initialConstraints()
    }
    
    
    private func setupImageViews() {
        fixedSize = sizeOfAspectFit(imageSize: image.size, containerSize: size)
        backgroundImageView.image = image.resizedImageWithinRect(rectSize: fixedSize)
        trackImageView.image = image.resizedImageWithinRect(rectSize: fixedSize)
    }
    
    private func initialConstraints() {
        /// edges equal to superview
        NSLayoutConstraint(item: backgroundImageView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: backgroundImageView, attribute: .left, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: backgroundImageView, attribute: .right, relatedBy: .lessThanOrEqual, toItem: self, attribute: .right, multiplier: 1, constant: 0).isActive = true
        
        backgroundImageView.heightAnchor.constraint(equalToConstant: fixedSize.height).isActive = true
        backgroundImageView.widthAnchor.constraint(equalToConstant: fixedSize.width).isActive = true
    }

    private func animateFromBottomConstraints(_ height: CGFloat) {
        trackIvHeightConstraint.constant = height
        trackIvHeightConstraint.isActive = true

        NSLayoutConstraint(item: trackImageView, attribute: .bottom, relatedBy: .equal, toItem: backgroundImageView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: trackImageView, attribute: .left, relatedBy: .equal, toItem: backgroundImageView, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: trackImageView, attribute: .right, relatedBy: .equal, toItem: backgroundImageView, attribute: .right, multiplier: 1, constant: 0).isActive = true
    }
    
    func sizeOfAspectFit(imageSize: CGSize, containerSize: CGSize) -> CGSize {
        var aspectFitSize = CGSize(width: containerSize.width, height: containerSize.height)
        let mW = containerSize.width / imageSize.width
        let mH = containerSize.height / imageSize.height
        if mH < mW {
            aspectFitSize.width = mH * imageSize.width
        } else if mW < mH {
            aspectFitSize.height = mW * imageSize.height
        }
        return aspectFitSize
    }
    
    
    public func setProgress(_ progress: CGFloat, animated: Bool, duration: TimeInterval = 0.2) {
        self.progress = progress
        let animationDuration = animated ? duration : 0
        let fixedProgress = min(max(0, progress), 1)
        
        UIView.animate(withDuration: animationDuration, animations: {
            switch self.fillDirection {
            case .fromBottom:
                self.animateFromBottomConstraints(fixedProgress * self.backgroundImageView.frame.height)
            }
            self.layoutIfNeeded()
        }, completion: { _ in
        })
    }
}


/// MARK: - Resize Image Extension

public extension UIImage {
    /*** Call this to prevent quality loss ***/
    func resizedImageWithinRect(rectSize: CGSize) -> UIImage {
        let widthFactor = size.width / rectSize.width
        let heightFactor = size.height / rectSize.height
        
        var resizeFactor = widthFactor
        if size.height > size.width {
            resizeFactor = heightFactor
        }
        
        let newSize = CGSize(width: size.width/resizeFactor, height: size.height/resizeFactor)
        let resized = resizedImage(newSize: newSize)
        return resized
    }
    
    func resizedImage(newSize: CGSize) -> UIImage {
        // guard newSize is different
        guard self.size != newSize else { return self }
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        guard let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        return newImage
    }
}
