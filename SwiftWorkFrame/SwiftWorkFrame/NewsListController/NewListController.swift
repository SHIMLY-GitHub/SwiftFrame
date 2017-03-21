//
//  NewListController.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/3/21.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import UIKit
struct TestFormable:SwiftFormable {
    
    var url: String = "http://www.1001piao.com/m_i/news/getNewList"
    
    var page:Int = 1
    
    func parameter() -> [String : Any] {
        
        return ["newsType":"XMFL_RD",
                "startRow":String(Int(self.page)),
                "pageSize":String(Int(self.page * 10))]
    }
    
}
class NewListController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var testFormable:TestFormable = TestFormable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.post(formable: testFormable)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

 

}
extension NewListController:NetWorkPotocol{
    
    func requestSuccess(dataObj: Any, formable: SwiftFormable) {
        
        let array =   NewsListModel().newsListArray(dataObj: dataObj)
        
        
        
        
    }
    
    func requestFieldBusiness(error: SwiftError, formable: SwiftFormable) {
        
    }
    
    func requestFieldSystem(error: SwiftError, formable: SwiftFormable) {
        
    }
    
}


