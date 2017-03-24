//
//  UIViewController+NavProtocol.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/3/24.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import UIKit
extension UIViewController{
    
    
    var naviagtion:NavigationProtocol?{
        
        get {
            
            return self as? NavigationProtocol
        }
    }
    
    func nextNavigationStyle() -> Void {
        
        self.leftNavigationItem()
        self.rightNavigationItem()
        
    }
    //MARK:左边导航栏
    func leftNavigationItem() -> Void {
        
        let backButton = UIButton(type: .custom)
        var leftImage = UIImage()
        
        if ((self.naviagtion?.leftItemImage()) != nil){
            
            leftImage = (self.naviagtion?.leftItemImage())!
        }else{
            leftImage = UIImage(named: "back")!
        }
        
        backButton.frame = CGRect(x: 0, y: 0, width: 10, height: 18)
        backButton.setBackgroundImage(leftImage, for: .normal)
        backButton.addTarget(self, action: #selector(UIViewController.backAction), for: .touchUpInside)
        let leftItem = UIBarButtonItem(customView: backButton)
        
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    
    //MARK: 右边导航栏
    func rightNavigationItem() -> Void {
        let rightImage = self.naviagtion?.rightItemImage()
        guard  (rightImage != nil) else {
            
            return
        }
        
        let rightButton = UIButton(type: .custom)
        
        rightButton.frame = CGRect(x: 0, y: 0, width: (rightImage?.size.width)!, height: (rightImage?.size.height)!)
        rightButton.setBackgroundImage(rightImage, for: .normal)
        rightButton.addTarget(self, action: #selector(UIViewController.rightAction), for: .touchUpInside)
        let rigthItem = UIBarButtonItem(customView: rightButton)
        
        self.navigationItem.rightBarButtonItem = rigthItem
    }
    
    //MARK: 右边按钮返回事件
    func rightAction() -> Void {
        
        self.naviagtion?.actionRightItemAction()
    }
    
    //MARK: 返回事件
    func backAction() -> Void {
        let controller  = self.navigationController?.popViewController(animated: true)
        
        if controller==nil {
            self.dismiss(animated: true, completion: nil)
        }
        
        self.naviagtion?.actionLeftItemAction()
    }
}
