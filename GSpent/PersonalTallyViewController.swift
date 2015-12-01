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

struct BookTally {
    var tallyTimeline: UIImage?
    var tallyTime:   String
    var tallyBrief:  String
    var tallyAmount: Double
}

class PersonalTallyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var bookSelectTableView: UITableView!
    @IBOutlet weak var bookTallyTableView:  UITableView!
    
    var books  = [BookINP]()
    var tallys = [BookTally]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookSelectTableView.delegate = self
        self.bookSelectTableView.dataSource = self
        self.bookSelectTableView.registerNib(UINib(nibName: "BookINPTableViewCell", bundle: nil), forCellReuseIdentifier: "bookINPTableViewCell")
        self.bookTallyTableView.delegate = self
        self.bookTallyTableView.dataSource = self
        self.bookTallyTableView.registerNib(UINib(nibName: "BookTallyTableViewCell", bundle: nil), forCellReuseIdentifier: "bookTallyTableViewCell")

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
        
        let tally1  = BookTally(tallyTimeline: image2, tallyTime: "2015-11-30 14:23", tallyBrief: "买奶粉", tallyAmount: 60.01)
        let tally2  = BookTally(tallyTimeline: image2, tallyTime: "2015-11-29 20:32", tallyBrief: "吃宵夜", tallyAmount: 700.00)
        let tally3  = BookTally(tallyTimeline: image2, tallyTime: "2015-11-29 12:01", tallyBrief: "64食堂油鸡髀", tallyAmount: 30.00)
        let tally4  = BookTally(tallyTimeline: image2, tallyTime: "2015-11-28 23:10", tallyBrief: "羞羞的东西", tallyAmount: 68.00)
        tallys    += [tally1, tally2, tally3, tally4]
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == self.bookSelectTableView ? self.books.count : self.tallys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(tableView){
        case self.bookSelectTableView:
            let cellIdentifier = "bookINPTableViewCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BookINPTableViewCell
            let book = books[indexPath.row]
            cell.bookIcon.image = book.bookIcon
            cell.bookName.text  = book.bookName
            cell.bookPart.text  = book.bookPart
            return cell
        case self.bookTallyTableView:
            let cellIdentifier = "bookTallyTableViewCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BookTallyTableViewCell
            let tally = tallys[indexPath.row]
            cell.tallyTimeline.image = tally.tallyTimeline
            cell.tallyTime.text      = tally.tallyTime
            cell.tallyBrief.text     = tally.tallyBrief
            cell.tallyAmount.text    = String(tally.tallyAmount)
            return cell
        default: return UITableViewCell()
        }
    }

}

