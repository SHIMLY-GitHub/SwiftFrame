//
//  AnimationButtonCell.swift
//  SwiftWorkFrame
//
//  Created by 董家祎 on 2017/4/25.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import UIKit

class AnimationButtonCell: UITableViewCell {
    @IBOutlet weak var button: SwiftButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.button.isSelectedAnimation = false;
    }

    @IBAction func buttonAction(_ sender: SwiftButton) {
        
        sender.isSelectedAnimation = !sender.isSelectedAnimation

        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
