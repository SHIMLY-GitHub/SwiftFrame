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
    var int:Int?{
        return Int(self)
    }
    
    
    
    
    
}
