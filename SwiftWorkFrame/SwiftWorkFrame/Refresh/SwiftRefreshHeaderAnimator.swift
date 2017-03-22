//
//  SwiftRefreshHeaderAnimator.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/3/22.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import UIKit
import ESPullToRefresh

class SwiftRefreshHeaderAnimator: UIView,ESRefreshProtocol, ESRefreshAnimatorProtocol {
    public var insets: UIEdgeInsets = UIEdgeInsets.zero
    public var view: UIView { return self }
    public var duration: TimeInterval = 0.3
    public var trigger: CGFloat = 56.0
    public var executeIncremental: CGFloat = 56.0
    public var state: ESRefreshViewState = .pullToRefresh
    
    private let imageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.frame = CGRect(x: 0, y: 0, width: 43, height: 9)
        imageView.image = UIImage.init(named: "dropdown_anim1")
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func refreshAnimationBegin(view: ESRefreshComponent) {
        imageView.center = self.center
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            /*  self.imageView.frame = CGRect.init(x: (self.bounds.size.width - 39.0) / 2.0,
             y: self.bounds.size.height - 50.0,
             width: 39.0,
             height: 50.0)*/
            
            
        }, completion: { (finished) in
            var images = [UIImage]()
            for idx in 1 ... 4 {
                if let aImage = UIImage(named: "dropdown_anim\(idx)") {
                    images.append(aImage)
                }
            }
            self.imageView.animationDuration = 0.5
            self.imageView.animationRepeatCount = 0
            self.imageView.animationImages = images
            self.imageView.startAnimating()
        })
    }
    
    public func refreshAnimationEnd(view: ESRefreshComponent) {
        imageView.stopAnimating()
        imageView.image = UIImage.init(named: "dropdown_anim1")
    }
    
    public func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
        /*
         let p = max(0.0, min(1.0, progress))
         imageView.frame = CGRect.init(x: (self.bounds.size.width - 39.0) / 2.0,
         y: self.bounds.size.height - 50.0 * p,
         width: 39.0,
         height: 50.0 * p)*/
    }
    
    public func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        guard self.state != state else {
            return
        }
        self.state = state
        
        switch state {
        case .pullToRefresh:
            var images = [UIImage]()
            for idx in 1 ... 4 {
                if let aImage = UIImage(named: "dropdown_anim\((4 - idx + 1))") {
                    images.append(aImage)
                }
            }
            imageView.animationDuration = 0.2
            imageView.animationRepeatCount = 1
            imageView.animationImages = images
            imageView.image = UIImage.init(named: "dropdown_anim1")
            imageView.startAnimating()
            break
        case .releaseToRefresh:
            var images = [UIImage]()
            for idx in 1 ... 4 {
                if let aImage = UIImage(named: "dropdown_anim1\(idx)") {
                    images.append(aImage)
                }
            }
            imageView.animationDuration = 0.2
            imageView.animationRepeatCount = 1
            imageView.animationImages = images
            imageView.image = UIImage.init(named: "dropdown_anim1")
            imageView.startAnimating()
            break
        default:
            break
        }
    }
    
    
}
