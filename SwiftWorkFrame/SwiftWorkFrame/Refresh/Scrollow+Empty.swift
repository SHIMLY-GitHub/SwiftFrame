//
//  Scrollow+Empty.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/3/23.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import UIKit

private var EmptyImageKey: Void?
private var EmptyProtovolKey: Void?
extension UIScrollView{
 
    
    var emptyImageView:UIImageView?{
        get {
            return (objc_getAssociatedObject(self, &EmptyImageKey) as! UIImageView?)
        }
        set {
            objc_setAssociatedObject(self, &EmptyImageKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    
    
   weak var emptyProtocol:SwiftEmptyProtocol?{
        get {
            return (objc_getAssociatedObject(self, &EmptyProtovolKey) as! SwiftEmptyProtocol?)
        }
        set {
            objc_setAssociatedObject(self, &EmptyProtovolKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        
    }
    
    
    
    //刷新方法
    public func swiftReload() -> Void{
      
        if self is UITableView {
            let tableView = self as! UITableView
            tableView.reloadData()
            
            let isEmpty = self.isEmptyTableView()
            
            guard isEmpty else {
                
                return
            }
          
            
             self.reloadEmptyImageView()
            
            return
        }
        
        if self is UICollectionView {
            let collectionView = self as! UICollectionView
            collectionView.reloadData()
            
            let isEmpty = self.isEmptyCollectionView(collectionView: collectionView)
            
            guard isEmpty else {
                return
            }
            
            self.reloadEmptyImageView()
            
            return
        }
        
        
    }
    
    //给空的scrollow添加 默认显示图片
    private func reloadEmptyImageView() -> Void{
        
        guard (emptyImageView == nil) else {
            
            return
        }
        let image = self.emptyProtocol?.emptyImage()
        
        self.emptyImageView?.translatesAutoresizingMaskIntoConstraints = false
        
        self.emptyImageView = UIImageView()
        
        self.emptyImageView?.image = image
        
        self.addSubview(self.emptyImageView!)
       
        self.emptyImageView?.frame = CGRect(x: 0, y: 0, width: (image?.size.width)!, height: (image?.size.height)!)
        
        self.emptyImageView?.center = CGPoint(x: self.center.x, y: self.center.y-(self.emptyProtocol?.imageViewOffsetY())!)
        
        guard self.emptyProtocol?.emptyString() == nil else {
            
            let label = UILabel()
            label.text = self.emptyProtocol?.emptyString()
            label.textAlignment = .center
            label.textColor = UIColor(red: 160/255.0, green: 160/255.0, blue: 160/255.0, alpha: 1)
            label.font = UIFont.systemFont(ofSize: 13)
            label.frame = CGRect(x: 0, y: (self.emptyImageView?.frame.size.height)!+(self.emptyImageView?.frame.origin.y)! + (self.emptyProtocol?.emptyLabelSpaceForImage())!, width: self.frame.size.width, height: 40)
            self.addSubview(label)
            
            return
        }
        
        guard ((self.emptyProtocol?.emptyLabel()) != nil) else {
            return
        }
        let label = self.emptyProtocol?.emptyLabel()
        
        self.addSubview(label!)
        
        label?.frame = CGRect(x: 0, y: (self.emptyImageView?.frame.size.height)!+(self.emptyImageView?.frame.origin.y)! + (self.emptyProtocol?.emptyLabelSpaceForImage())!, width: self.frame.size.width, height: 40)
        
        label?.textAlignment = .center
        
        
        
    }
    
    //MARK:判断collectionView 是否为空
    private  func isEmptyCollectionView(collectionView:UICollectionView) -> Bool {
        
        let sections = collectionView.numberOfSections
        
        var itemTotal:Int = 0
        
        for section in 0..<sections{
            
            let items = collectionView.numberOfItems(inSection: section)
            
            itemTotal = items + itemTotal
        }
        
        guard itemTotal==0 else {
            return false
        }
        
        return true
        
        
    }
    
    //判断tableView是否为空
    private func isEmptyTableView()->Bool{
        let tableView = self as! UITableView
        
        let sections = tableView.numberOfSections
        
        var rowsTotal:Int = 0
        for section in 0..<sections{
            
            let rows = tableView.numberOfRows(inSection: section)
            
            rowsTotal = rows + rowsTotal
        }
        guard rowsTotal==0 else {
            return false
        }
        return true
    }
    
    
    
}

