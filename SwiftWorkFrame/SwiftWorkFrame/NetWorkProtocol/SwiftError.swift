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
    }

    
}
