//
//  bookTableViewCell.swift
//  GSpent
//
//  Created by Jiahe Liu on 29/11/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//

import UIKit

class bookTableViewCell: UITableViewCell {
    
    @IBOutlet var imgBookAvatar: UIImageView!
    
    @IBOutlet var lblBookLastUp: UILabel!
    @IBOutlet var lblBookMates: UILabel!
    @IBOutlet var lblBookName: UILabel!
    
    @IBOutlet weak var lblBookAmount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgBookAvatar.layer.cornerRadius = self.imgBookAvatar.frame.size.width/10
        //        self.imgBookAvatar.layer.borderWidth = 10
        //        self.imgBookAvatar.layer.borderColor = UIColor.whiteColor().CGColor
        self.imgBookAvatar.clipsToBounds = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
