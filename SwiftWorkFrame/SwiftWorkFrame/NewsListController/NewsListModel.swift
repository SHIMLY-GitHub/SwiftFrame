//
//  NewsListModel.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/3/21.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import Foundation
import ObjectMapper



struct NewsListModel:Mappable {
    
    var simg:String?
    var title:String?
    var share_volume:Int = 0
    var bimg:String?
    var browse_volume:Int = 0
    var xwnrFileName:String?
    var id:Int = 0
    var createtimestamp:Int = 0
    
    
    init() {
        
    }
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        simg  <- map["simg"]
        title <- map["title"]
        share_volume <- map["share_volume"]
        bimg  <- map["bimg"]
        browse_volume <- map["browse_volume"]
        xwnrFileName <- map["xwnrFileName"]
        id <- map["id"]
        createtimestamp <- map["createtimestamp"]
        
    }
    
}

extension NewsListModel{
    
    
    func newsListArray(dataObj:Any) -> [NewsListModel] {
        
        let array = Mapper<NewsListModel>().mapArray(JSONArray: dataObj as! [[String : Any]])!
        SwiftCache.globalCache.setObject(anyObject: array.toJSON(), key: "cecece")
    
        return array
    }
   
}








