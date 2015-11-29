//
//  BookIconNamePeople.swift
//  GSpent
//
//  Created by HUI ZHAN on 11/29/15.
//  Copyright © 2015 LIU Jiahe. All rights reserved.
//

import UIKit

class BookIconNamePeople {
    var bookIcon: UIImage?
    var bookName: String
    var bookPeople: String
    
    init?(icon: UIImage?, name: String, people: String) {
        // Initialize stored properties.
        self.bookIcon = icon
        self.bookName = name
        self.bookPeople = people
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty ||  people.isEmpty {
            return nil
        }
    }
}
