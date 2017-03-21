//
//  ParameterFormable.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/3/21.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import Foundation
public protocol SwiftFormable{
    var url:String {get}
    
  //  var parameter:[String:Any] {get}
    
    func parameter() -> [String:Any]
    
}

