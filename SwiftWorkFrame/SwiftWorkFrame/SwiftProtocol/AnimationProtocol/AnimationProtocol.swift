//
//  AnimationProtocol.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/4/25.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import UIKit

protocol ButtonScanAnimationProtocol {}
extension ButtonScanAnimationProtocol where Self:UIButton{
    
    func normalAnimation() {

        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.imageView?.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            
        }) { (falg) in}
    }
    
    func selectAnimation() {
        
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: -20, options: .curveEaseIn, animations: {
            self.imageView?.transform  = CGAffineTransform(scaleX: 1.2, y: 1.2);
            
        }) { (falg)in}}
    
    
}




class SwiftButton:UIButton,ButtonScanAnimationProtocol {
    
    var isSelectedAnimation: Bool!{
        willSet{
            self.isSelected = newValue
            
            if newValue {
                self.selectAnimation()
            }else{
                self.normalAnimation()
            }
            
        }
        
    }
    
    
    
    
    
}

extension SwiftButton{
    
  
    
    
}






