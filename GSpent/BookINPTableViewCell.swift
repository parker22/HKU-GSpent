//
//  BookINPTableViewCell.swift
//  GSpent
//
//  Created by HUI ZHAN on 12/1/15.
//  Copyright © 2015 LIU Jiahe. All rights reserved.
//

import UIKit

class BookINPTableViewCell: UITableViewCell {

    @IBOutlet weak var bookIcon: UIImageView!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookPart: UILabel!
    @IBOutlet weak var bookID  : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bookIcon.layer.cornerRadius = bookIcon.frame.size.width/3
        bookIcon.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
