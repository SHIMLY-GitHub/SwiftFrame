//
//  Scrollow+Refresh.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/3/22.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import Foundation
import ESPullToRefresh


private var ScrollowProtocolKey: Void?


extension UIScrollView{
    
    weak var scrollowProtocol:SwiftRefreshProtocol?{
        
        get {
            return (objc_getAssociatedObject(self, &ScrollowProtocolKey) as? SwiftRefreshProtocol)
        }
        set(newValue) {
            objc_setAssociatedObject(self, &ScrollowProtocolKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            self.addScrollowAutoRefresh()
        }
    }
    //停止刷新所有
    public func stopAllRefresh() -> Void {
        self.es_stopLoadingMore()
        self.es_stopPullToRefresh()
    }
    private  func addScrollowAutoRefresh() -> Void {
        self.scrollowRefreshPullDown()
        self.scrollowRefreshPullUp()
        self.es_startPullToRefresh()
    }
    
 
    
    //下拉刷新
    private  func scrollowRefreshPullDown() -> Void {
        
        let wpRefreshHeader = SwiftRefreshHeaderAnimator.init(frame: CGRect.zero) as ESRefreshAnimatorProtocol & ESRefreshProtocol
        _ = self.es_addPullToRefresh(animator: wpRefreshHeader, handler: { [weak self] in
            
            self?.scrollowProtocol?.refreshPullDown()
        })
        
    }
    //上拉加载更多
    private func scrollowRefreshPullUp() -> Void {
        
        guard (self.scrollowProtocol?.isPullUp())! else {
            return
        }
        
        let wpRefreshFooter = SwiftRefreshHeaderAnimator.init(frame: CGRect.zero) as ESRefreshAnimatorProtocol & ESRefreshProtocol
        _ = self.es_addInfiniteScrolling(animator: wpRefreshFooter) { [weak self] in
            
            
            
            self?.scrollowProtocol?.refreshPullUp()
        }
    }
}

