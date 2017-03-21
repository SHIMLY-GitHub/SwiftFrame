//
//  NetWorkProtocol.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/3/21.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import Foundation
import Alamofire

protocol NetWorkPotocol {
    ///requestSuccess:请求数据成功回调
    /// - parameter dataObj : 返回数据
    /// - parameter paramenter: 请求数据的时候传入的参数 
    
    func requestSuccess(dataObj:Any,formable:SwiftFormable)
    
    
    
    ///requestFieldBusiness:用于业务逻辑返回的错误 例如 302
    /// - parameter error : 返回的错误信息
    /// - parameter parameter: 请求数据的时候传入的参数
    func requestFieldBusiness(error:SwiftError,formable:SwiftFormable)
    
    
    
    ///requestFieldSystem:用于系统返回的错误 例如 404 405
    /// - parameter error : 返回的错误信息
    /// - parameter parameter: 请求数据的时候传入的参数
    func requestFieldSystem(error:SwiftError,formable:SwiftFormable)
}



extension NetWorkPotocol where Self:UIViewController {
  
    func post(formable:SwiftFormable) -> Void {
        
        self.alamofire(url: formable.url, params: formable.parameter(), compleSuccess: { [weak self](dataObj)  in
            
            self?.requestSuccess(dataObj: dataObj, formable: formable)
            
        }, compleFailureBusioness: {  [weak self] (code,message) in
           
           self?.requestFieldBusiness(error:  SwiftError(code: 1, message: "业务失败"), formable: formable)
            
        }) {  [weak self]  (error)  in
            
            self?.requestFieldSystem(error: SwiftError(code: 2, message: "404"), formable:formable)
        }
        
    }
    
    private func alamofire(url:String,
                           params:[String:Any],
                           compleSuccess:@escaping (_ dataObj:Any)->Void,
                           compleFailureBusioness:@escaping (_ code:Int,_ message:String)->Void,
                           compleFailureSystem:@escaping (_ error:Error)->Void){
            
        
        Alamofire.request(url, method: .post, parameters:params, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse) in

            switch response.result.isSuccess{
            case true:
                var resultValue = response.result.value as! [String : Any]
                
                let code = resultValue[SwiftCode] as! String
                let message = resultValue[SwiftMessage] as! String
                
                guard code=="0" else{
                    
                    compleFailureBusioness(Int(code)!,message)
                    return
                }
                
                guard resultValue[SwiftBody] != nil else {
                    
                    compleFailureBusioness(-900,SwiftBody+"为空")
                    return
                }
               
                let dataObj = resultValue[SwiftBody]
                
                compleSuccess(dataObj as Any)
                
            case false:
                compleFailureSystem(response.result.error!)
                
            }
            
        }
            
   
        
    }
    
}

extension NetWorkPotocol {
    
    func requestSuccess(dataObj:Any,formable:SwiftFormable){
        
    }
    
    func requestFieldBusiness(error:SwiftError,formable:SwiftFormable){
        
    }
    func requestFieldSystem(error:SwiftError,formable:SwiftFormable){
        
    }
    
    
}













