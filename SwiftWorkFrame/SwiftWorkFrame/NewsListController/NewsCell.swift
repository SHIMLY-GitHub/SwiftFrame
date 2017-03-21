//
//  NewsCell.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/3/21.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var blowNumberLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    var newsModel:NewsListModel!{
        willSet{
            newsTitleLabel.text = newValue.title
            blowNumberLabel.text = newValue.browse_volume.string
            newsImageView.setImage(url: "http://www.1001piao.com"+newValue.bimg!)
            
            
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
