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
    
    var page:Int = 0
    
    func parameter() -> [String : Any] {
        
        return ["newsType":"XMFL_RD",
                "startRow":(self.page * 10).toString,
                "pageSize":10.toString]
    }
    
}
class  NewListController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var newsListFormabel:NewsListFormable = NewsListFormable()
    var dataSource:[NewsListModel] = []
    
    var request: Alamofire.Request?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.tableView.scrollowProtocol = self;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.request?.cancel()
        
        
        
    }
    deinit {
        
        print("销毁");
    }
    

 

}

extension NewListController:SwiftRefreshProtocol{
    
    func refreshPullDown() {
        newsListFormabel.page = 0
        self.request =  self.swiftPost(formable: newsListFormabel)
    }
    func refreshPullUp() {
        newsListFormabel.page = newsListFormabel.page + 1
        
        
        self.request = self.swiftPost(formable: newsListFormabel);
    }
    
  
}

extension NewListController:NetWorkPotocol{
    
    
    func requestSuccess(dataObj: Any, formable: SwiftFormable) {
        
        let array = NewsListModel().newsListArray(dataObj: dataObj)
        
        if newsListFormabel.page==0 {
            self.dataSource =   array
            self.tableView.es_stopPullToRefresh()
            
        }else{
        
            self.dataSource.append(contentsOf: array)
            
            self.tableView.es_stopLoadingMore()
        }
        
        
        self.tableView.reloadData()
        
        
    }
    
    func requestFieldBusiness(error: SwiftError, formable: SwiftFormable) {
        
        self.tableView.stopAllRefresh()
        
    }
    
    func requestFieldSystem(error: SwiftError, formable: SwiftFormable) {
        
         self.tableView.stopAllRefresh()
    }
    
}


