//
//  BookTallyTableViewCell.swift
//  GSpent
//
//  Created by HUI ZHAN on 12/1/15.
//  Copyright © 2015 LIU Jiahe. All rights reserved.
//

import UIKit

class BookTallyTableViewCell: UITableViewCell {

    @IBOutlet weak var tallyTimeline: UIImageView!
    @IBOutlet weak var tallyTime: UILabel!
    @IBOutlet weak var tallyBrief: UILabel!
    @IBOutlet weak var tallyAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
