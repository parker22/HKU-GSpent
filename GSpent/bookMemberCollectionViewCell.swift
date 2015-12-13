//
//  bookMemberCollectionViewCell.swift
//  GSpent
//
//  Created by Jiahe Liu on 3/12/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//

import UIKit

class bookMemberCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bookMemberAvatar: UIImageView!
    
    override func awakeFromNib() {
        self.bookMemberAvatar.layer.cornerRadius = self.bookMemberAvatar.frame.size.width/2
        self.bookMemberAvatar.clipsToBounds = true
        self.bookMemberAvatar.layer.borderWidth = 2
        self.bookMemberAvatar.layer.borderColor = UIColor.grayColor().CGColor
    }
}
