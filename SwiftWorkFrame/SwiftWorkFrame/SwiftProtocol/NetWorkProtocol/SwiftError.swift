//
//  SwiftError.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/3/21.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import Foundation


public struct SwiftError{
    
    var code:Int!
    
    var message:String!
    
   
    init(code:Int,message:String) {
        
        self.code = code;
        self.message = message;
        switch code {
        case -999:
             self.message = "请求已取消"
             break
        case 404:
            self.message  = "url地址错误"
            break
        case 500:
            self.message  = "服务器异常"
        case -1009:
            self.message  = "网络未连接"
        default: break
            
        }
        
    }

    
}
