//
//  NetWorkProtocol.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/3/21.
//  Copyright © 2017年 董家祎. All rights reserved.
//
import Foundation
import Alamofire

protocol  NetWorkPotocol{
    ///requestSuccess:请求数据成功回调
    /// - parameter dataObj : 返回数据
    /// - parameter paramenter: 请求数据的时候传入的参数 
    
   func requestSuccess(dataObj:Any,formable:SwiftFormable)
    
    
    
    ///requestFieldBusiness:用于业务逻辑返回的错误 例如 302
    /// - parameter error : 返回的错误信息
    /// - parameter parameter: 请求数据的时候传入的参数
    func requestFieldBusiness(error:SwiftError,formable:SwiftFormable)
    
    
    
    ///requestFieldSystem:用于系统返回的错误 例如 404 405
    /// - parameter error : 返回错误信息
    /// - parameter parameter: 请求数据的时候传入的参数
    func requestFieldSystem(error:SwiftError,formable:SwiftFormable)
}


extension NetWorkPotocol where Self:UIViewController{
  
    @discardableResult
    func swiftPost(formable:SwiftFormable) -> Alamofire.Request {
        
      
       return self.alamofire(url: formable.url, params: formable.parameter(), compleSuccess: { [weak self](dataObj)  in
            
            self?.requestSuccess(dataObj: dataObj, formable: formable)
            
        }, compleFailureBusioness: {  [weak self] (code,message) in
           
           self?.requestFieldBusiness(error:  SwiftError(code: code, message: message), formable: formable)
            
        }) {  [weak self]  (error)  in
           
           let errorCode = (error as NSError).code
           let errorMessage = (error as NSError).description
            
            self?.requestFieldSystem(error: SwiftError(code: errorCode, message: errorMessage), formable:formable)
        }
        
    }
    

    
    @discardableResult
    private   func alamofire(url:String,
                           params:[String:Any],
                           compleSuccess:@escaping (_ dataObj:Any)->Void,
                           compleFailureBusioness:@escaping (_ code:Int,_ message:String)->Void,
                           compleFailureSystem:@escaping (_ error:Error)->Void) ->Alamofire.Request {
    //认证服务端
      self.authService()
    
      return Alamofire.request(url, method: .post, parameters:params, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse) in

            switch response.result.isSuccess{
            case true:
                var resultValue = response.result.value as! [String : Any]
                
                let code = resultValue[SwiftCode] as! String
                let message = resultValue[SwiftMessage] as! String
                
                guard code==SwiftSuccessStatus else{
                    
                    compleFailureBusioness(Int(code)!,message)
                    return
                }
                
                guard resultValue[SwiftBody] != nil else {
                    
                    compleFailureBusioness(-900,SwiftBody+"为nil")
                    return
                }
               
                let dataObj = resultValue[SwiftBody]
                
                compleSuccess(dataObj as Any)
                
            case false:
               
                compleFailureSystem(response.result.error!)
                
            }
            
        }
        
        
            
   
        
    }
    
    //MARK:适配https 认证服务端证书
    ///copy http://www.hangge.com/blog/cache/detail_1052.html
    
    func authService() -> Void {
        
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            if challenge.protectionSpace.authenticationMethod
                == NSURLAuthenticationMethodServerTrust {
                let serverTrust:SecTrust = challenge.protectionSpace.serverTrust!
                let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0)!
                let remoteCertificateData
                    = CFBridgingRetain(SecCertificateCopyData(certificate))!
                let cerPath = Bundle.main.path(forResource: "wanpiao", ofType: "cer")!
                let cerUrl = URL(fileURLWithPath:cerPath)
                let localCertificateData = try! Data(contentsOf: cerUrl)
                
                if (remoteCertificateData.isEqual(localCertificateData) == true) {
                    
                    let credential = URLCredential(trust: serverTrust)
                    challenge.sender?.use(credential, for: challenge)
                    return (URLSession.AuthChallengeDisposition.useCredential,
                            URLCredential(trust: challenge.protectionSpace.serverTrust!))
                    
                } else {
                    return (.cancelAuthenticationChallenge, nil)
                }
            }
            
            return (.cancelAuthenticationChallenge, nil)
        }
        
        
        
    }
    
}

extension NetWorkPotocol {
    func requestSuccess(dataObj:Any,formable:SwiftFormable){}
    func requestFieldBusiness(error:SwiftError,formable:SwiftFormable){}
    func requestFieldSystem(error:SwiftError,formable:SwiftFormable){}
    
}













