//
//  SwiftMappable.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/4/20.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import Foundation
import ObjectMapper
extension Mappable{

    
    func cacheObject<T:Mappable>(key:String) -> [T] {
        
        let object = SwiftCache.globalCache.objectValue(key: key)
        
        if object == nil {
            
            return []
        }
        let array = Mapper<T>().mapArray(JSONArray: object as! [[String:Any]])!
        
        return array
        
    }
}
