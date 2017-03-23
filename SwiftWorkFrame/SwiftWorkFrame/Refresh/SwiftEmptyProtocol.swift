//
//  SwiftEmptyProtocol.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/3/23.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import UIKit
protocol SwiftEmptyProtocol:class {
    //有一个默认值 noData
    func emptyImage() -> UIImage?
    
    //显示文字
    func emptyLabel() -> UILabel?
    
    // 设置Y轴的偏移量
    func imageViewOffsetY() -> CGFloat
    
    //设置 labe 距离 emptyimage的 间距
    func emptyLabelSpaceForImage() -> CGFloat
    
    //设置 空白显示文字
    //MARK: 如果设置了 空白文字 再设置了 emptyLabel 则 emptyLabel无效
    func emptyString() -> String?
}


extension SwiftEmptyProtocol {
    
    func emptyImage() -> UIImage?{
        
        return UIImage(named: "noData")
    }
    
    func imageViewOffsetY() -> CGFloat{
        
        return 64.0
    }
    func emptyLabel() -> UILabel?{
        return nil
    }
    func emptyLabelSpaceForImage() -> CGFloat{
        return 5.0
    }
    func emptyString() -> String? {
        return nil
    }
}
