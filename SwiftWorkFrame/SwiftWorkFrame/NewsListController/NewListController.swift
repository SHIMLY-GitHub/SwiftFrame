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
    
    var url: String = "https://www.1001piao.com:8443/m_i/news/getNewList"
    
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
        self.nextNavigationStyle()
        self.title = "新闻"
        self.tableView.scrollowProtocol = self;
        self.tableView.emptyProtocol    = self;
        self.tableView.tableFooterView = UIView()
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

//MARK:空白页面处理协议
extension NewListController:SwiftEmptyProtocol{}


//MARK:刷新协议
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
//MARK:请求协议
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
        
        
        self.tableView.swiftReload()
        
        
    }
    
    func requestFieldBusiness(error: SwiftError, formable: SwiftFormable) {
        
        self.tableView.stopAllRefresh()
        
    }
    
    func requestFieldSystem(error: SwiftError, formable: SwiftFormable) {
        
        
         self.tableView.stopAllRefresh()
    }
    
}


