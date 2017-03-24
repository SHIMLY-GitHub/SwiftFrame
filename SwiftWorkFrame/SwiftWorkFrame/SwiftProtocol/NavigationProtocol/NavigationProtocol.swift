//
//  NavigationProtocol.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/3/24.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import UIKit

protocol NavigationProtocol {
    /// 导航栏右边的图片
    func rightItemImage() -> UIImage?
    
    /// 右边按钮点击事件
    func actionRightItemAction() -> Void
    
    /// 导航栏左边 按钮图片
    func leftItemImage() -> UIImage?
    
    /// 导航栏左边按钮点击事件
    func actionLeftItemAction() -> Void
    
    func titleColor() -> UIColor?
    
    func titleFont() -> UIFont?
    
}
extension NavigationProtocol{
    //MARK:可以根据自己需求在这几个方法里面进行默认实现
    
    func rightItemImage() -> UIImage?{
        
        return nil;
    }
    
    func actionRightItemAction() -> Void{
        
    }
   
    func leftItemImage() -> UIImage?{
        return nil
    }
    
    func actionLeftItemAction() -> Void{
        
        
    }
    func titleColor() -> UIColor?{
        return UIColor.red
    }
    
    func titleFont() -> UIFont?{
        return UIFont.systemFont(ofSize: 16)
    }
    
}
