//
//  PersonalTallyViewController.swift
//  GSpent
//
//  Created by Jiahe Liu on 28/11/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//

import UIKit

struct BookINP {
    var bookIcon: UIImage?
    var bookName: String
    var bookPart: String
}

class PersonalTallyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var bookSelectTableView: UITableView!
    @IBOutlet weak var bookTallyTableView:  UITableView!
    
    var books  = [BookINP]()
    var books2 = [BookINP]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookSelectTableView.delegate = self
        self.bookSelectTableView.dataSource = self
        self.bookSelectTableView.registerNib(UINib(nibName: "BookINPTableViewCell", bundle: nil), forCellReuseIdentifier: "bookINPTableViewCell")
        self.bookTallyTableView.delegate = self
        self.bookTallyTableView.dataSource = self
        self.bookTallyTableView.registerNib(UINib(nibName: "BookINPTableViewCell", bundle: nil), forCellReuseIdentifier: "bookINPTableViewCell")

        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        // here
    }
    
    func loadData(){
        let image1 = UIImage(named: "bookAvatarDefault")
        let image2 = UIImage(named: "testImageJin")
        let image3 = UIImage(named: "testImageBa")
        let book1  = BookINP(bookIcon: image1, bookName: "毛泽东同志的私人小账本", bookPart: "毛泽东、毛泽西")
        let book2  = BookINP(bookIcon: image2, bookName: "我叫金三胖", bookPart: "三胖、二胖 等18位胖子")
        let book3  = BookINP(bookIcon: image3, bookName: "我不干了", bookPart: "你、我、他 都不干了")
        books     += [book1, book2, book3]
        
        let book4  = BookINP(bookIcon: image2, bookName: "hehe", bookPart: "somebody")
        let book5  = BookINP(bookIcon: image2, bookName: "hehe", bookPart: "somebody")
        let book6  = BookINP(bookIcon: image2, bookName: "hehe", bookPart: "somebody")
        let book7  = BookINP(bookIcon: image2, bookName: "hehe", bookPart: "somebody")
        books2    += [book4, book5, book6, book7]
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == self.bookSelectTableView ? self.books.count : self.books2.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "bookINPTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BookINPTableViewCell
        let book = tableView == self.bookSelectTableView ? books[indexPath.row] : books2[indexPath.row]
        cell.bookIcon.image = book.bookIcon
        cell.bookName.text  = book.bookName
        cell.bookPart.text  = book.bookPart
        
        return cell
    }

}

