//
//  SwiftImage.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/3/21.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    func setImage(url:String) -> Void {
        let url = URL(string:url)
        
        self.kf.setImage(with: url, placeholder: UIImage(named: "morenwanpiao"), options: [.transition(ImageTransition.flipFromLeft(1))], progressBlock: { (receivedSize, totalSize) in
            
            
        }) { (image, error, cacheType, imageURL) in
            
            
        }
    }
}
extension Array{
    
    func cache(key:String) -> Void {
        
         SwiftCache.globalCache.setObject(anyObject: self, key: key)
    }
    
  
}
