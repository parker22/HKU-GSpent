//
//  bookDetailTallyTableViewCell.swift
//  GSpent
//
//  Created by Jiahe Liu on 10/12/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//

import UIKit

class bookDetailTallyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookTallyAmountLbl: UILabel!
    @IBOutlet weak var bookTallyDescriptionLbl: UILabel!
    @IBOutlet weak var bookTallyAvatarIV: UIImageView!
    @IBOutlet weak var bookTallyDatetimeLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
