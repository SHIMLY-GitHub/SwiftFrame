//
//  SwiftString.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/3/21.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import Foundation
extension String {
    
    ///字符串去空格
    var trim:String?{
         let whiteSpace = CharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whiteSpace)
    }
    /// string 转 int
    var toInt:Int?{
        return Int(self)
    }
    //MARK: 获取字符串 长度
    var length:Int? {
        
        
        let string = self.trim
        return string?.characters.count
        
    }
    
  
    
    
    //MARK: 验证手机号
    var isMobile:Bool? {
        
        guard self.length==11 else {
            return false
        }
        
        let index = self.index(self.startIndex, offsetBy: 1)
        
        let firseNUmber = self.trim?.substring(to: index)
        
        guard  firseNUmber=="1" , self.length==11 else {
            
            return false
        }
        
        return true
    }
    
    
    
    
    
}
