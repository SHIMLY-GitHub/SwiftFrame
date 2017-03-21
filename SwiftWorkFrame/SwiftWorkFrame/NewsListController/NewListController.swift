//
//  NewListController.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/3/21.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import UIKit
import Alamofire
struct NewsListFormable:SwiftFormable {
    
    var url: String = "http://www.1001piao.com/m_i/news/getNewList"
    
    var page:Int = 1
    
    func parameter() -> [String : Any] {
        
        return ["newsType":"XMFL_RD",
                "startRow":self.page.toString,
                "pageSize":(self.page * 10).toString]
    }
    
}
class NewListController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var newsListFormabel:NewsListFormable = NewsListFormable()
    var dataSource:[NewsListModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.post(formable: newsListFormabel)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

 

}
extension NewListController:NetWorkPotocol{
    
   
    
    
    func requestSuccess(dataObj: Any, formable: SwiftFormable) {
        
        self.dataSource =   NewsListModel().newsListArray(dataObj: dataObj)
        
        self.tableView.reloadData()
        
        
    }
    
    func requestFieldBusiness(error: SwiftError, formable: SwiftFormable) {
        
    }
    
    func requestFieldSystem(error: SwiftError, formable: SwiftFormable) {
        
    }
    
}


