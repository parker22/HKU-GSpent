//
//  bookTblCell.swift
//  GSpent
//
//  Created by Jiahe Liu on 29/11/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//

import UIKit

class bookTblCell: UITableViewCell {

    @IBOutlet weak var imgBookAvatar: UIImageView!
    @IBOutlet weak var lblBookName: UILabel!
    
    @IBOutlet weak var lblBookMates: UILabel!
    @IBOutlet weak var lblBookLastUp: UILabel!
    @IBOutlet weak var lblBookOU: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
