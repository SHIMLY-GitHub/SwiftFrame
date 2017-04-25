//
//  AnimationListController.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/4/25.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import UIKit

class AnimationListController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "buttonList"
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    deinit {
        
        print("销毁");
    }
    
}

extension AnimationListController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as AnimationButtonCell
        
        
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }

    
}











