//
//  UIViewProtocol.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/3/23.
//  Copyright © 2017年 董家祎. All rights reserved.
//


import UIKit

protocol ResuableView:class {}

extension ResuableView where Self:UIView{
    
    
    static var resuseIdentifier: String{
        
        return String(describing: self)
    }
    
}

protocol NibLoadableView:class {}
extension NibLoadableView where Self:UIView{
    
    static var NibName:String{
        
        return String(describing: self)
    }
    
}

protocol StoryBoardNibController:class {}

extension StoryBoardNibController where Self:UIViewController{
    
    static var storyBoardName:String {
        
        return String(describing: self)
    }
    
}
extension UIViewController:StoryBoardNibController{}


extension UICollectionReusableView: ResuableView,NibLoadableView{}

extension UITableViewCell:ResuableView{}


extension UIStoryboard {
    
    
    
    func instantiateViewController<T:UIViewController>(_: T.Type) -> T where T:StoryBoardNibController {
        
        guard let controller = instantiateViewController(withIdentifier: T.storyBoardName) as? T else {
            
            fatalError("没有通过 Identifier 获取到 controller")
        }
        return controller
        
    }
}
extension UITableView{
    
    func dequeueReusableCell<T:UITableViewCell> (indexPath:IndexPath) -> T where T:ResuableView {
        
        guard let cell = dequeueReusableCell(withIdentifier: T.resuseIdentifier, for: indexPath) as? T  else {
            
            fatalError("不能通过identifier获取到cell: \(T.resuseIdentifier)")
        }
        
        return cell
        
    }
}

extension UICollectionView {
    
    
    func registerHeader<T: UICollectionReusableView>(_: T.Type) where T: ResuableView, T: NibLoadableView {
        
        let nib = UINib(nibName: T.NibName, bundle: nil)
        register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: T.resuseIdentifier)
    }
    
    /* 
    func registerCHTHeaderArr<T:UICollectionReusableView>(classNames:[(_:T.Type)]) where T:ResuableView,T:NibLoadableView  {
        
        for className in classNames {
            
            register(UINib(nibName: className.NibName, bundle: nil), forSupplementaryViewOfKind: CHTCollectionElementKindSectionHeader, withReuseIdentifier: className.resuseIdentifier)
        }
        
    }*/
    
    func dequeueReusableCell<T:UICollectionViewCell>(indexPath: IndexPath) -> T where T:ResuableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.resuseIdentifier, for: indexPath) as? T  else {
            fatalError("不能通过identifier获取到cell: \(T.resuseIdentifier)")
        }
        
        return cell
    }
    
    func dequeueReusableSectionHeader<T:UICollectionReusableView>(indexPath:IndexPath) -> T where T:ResuableView {
        guard let reauableView = dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: T.resuseIdentifier, for: indexPath) as? T else {
            fatalError("不能通过identifier获取到UICollectionReusableView: \(T.resuseIdentifier)")
        }
        
        return reauableView;
    }
    
}






