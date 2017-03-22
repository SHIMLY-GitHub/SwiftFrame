//
//  SwiftRefreshProtocol.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/3/22.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import Foundation
import ESPullToRefresh

protocol SwiftRefreshProtocol:class {
    
    ///refreshPullDown:下拉刷新
   
    
    func refreshPullDown() -> Void
    ///refreshPullUp:上拉加载更多
    
    func refreshPullUp() -> Void
     ///isPullUp:是否需要上拉加载更多 默认为true
    
    func isPullUp() -> Bool

    
}

extension SwiftRefreshProtocol{
    
    func refreshPullDown(){
        
    }
    func refreshPullUp(){
        
    }
    //是否需要下拉加载更多 默认是 true
    func isPullUp() -> Bool{
        return true
    }
}
