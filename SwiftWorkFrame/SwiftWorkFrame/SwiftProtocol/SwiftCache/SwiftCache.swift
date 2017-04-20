//
//  SwiftCache.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/4/20.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import UIKit
import ObjectMapper

 class SwiftCache {
    
    static let globalCache  = SwiftCache()
    var diskQueue = DispatchQueue(label: "com.swiftCache.disk.queue", attributes: .concurrent)
    
    var diskCachePath:String = ""
    
    var director:String = ""
    var cacheInfo:[String:Any] = [:]
    
    init() {
        //home目录
       var cachesDirectory = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
      
        cachesDirectory = cachesDirectory.appendingFormat("/%@", Bundle.main.bundleIdentifier!).appending("/SwiftCache").copy() as! String
        if !FileManager.default.fileExists(atPath: cachesDirectory) {
            do {
                try FileManager.default.createDirectory(atPath: cachesDirectory, withIntermediateDirectories: true, attributes: nil)
                
            } catch  {
                
                print("缓存目录创建失败");
            }
        }
        
        
        self.diskCachePath = cachesDirectory;
 
        
    }
  private  func setData(data:Data,key:String) -> Void {
        
        
        let diskURL = URL(fileURLWithPath: self.diskCachePath(key: key))
        
        self.diskQueue.async {
            
            do{
                try data.write(to: diskURL)
                
            }
            catch{
                print("文件写入失败")
            }
        }
    }
    

  
    //根据key 获取缓存路径
   private func diskCachePath(key:String) -> String {
    
    
        return self.diskCachePath.appendingFormat("/%@",key)
        
    }
    
   public func objectValue(key:String) -> Any? {
        
        let url = URL(fileURLWithPath: self.diskCachePath(key: key))
        
        
        do {
            let data =  try Data(contentsOf: url)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                
                return json
                
            } catch  {
                
                return nil
                
            }
            
            
        } catch  {
            
            return nil
        }

        
    }
    
   public func setObject(anyObject:Any,key:String) -> Void {

        do{
            let data = try JSONSerialization.data(withJSONObject: anyObject, options: [])
            
             self.setData(data: data, key: key)
        }
        catch{
            print("json转化data失败")
        }
        
    }
    
 
    
   
}
