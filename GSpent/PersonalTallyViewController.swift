//
//  PersonalTallyViewController.swift
//  GSpent
//
//  Created by Jiahe Liu on 28/11/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//

import UIKit
import Parse

//let USER_ID = 22 // this HERO is Laurence

class PersonalTallyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var pageTitle: UINavigationItem!
    @IBOutlet weak var bookSelectTableView: UITableView!
    @IBOutlet weak var bookTallyTableView: UITableView!
    @IBOutlet weak var bookSelectedView: UIView!
    @IBOutlet weak var bookSelectedIcon: UIImageView!
    @IBOutlet weak var bookSelectedName: UILabel!
    @IBOutlet weak var bookSelectedPart: UILabel!
    @IBOutlet weak var bookSelectionArrow: UIImageView!
    
    static var books  = [PFObject]()
    static var tallys = [Tally]()
    var bookSelected: Book!
    var dataRepository = DataRepository()
    let arrowUp   = UIImage(named: "arrow_up")
    let arrowDown = UIImage(named: "arrow_down")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bookSelectTableView.delegate = self
        self.bookSelectTableView.dataSource = self
        self.bookSelectTableView.registerNib(UINib(nibName: "BookINPTableViewCell", bundle: nil),
            forCellReuseIdentifier: "bookINPTableViewCell")
        
        self.bookTallyTableView.delegate = self
        self.bookTallyTableView.dataSource = self
        self.bookTallyTableView.registerNib(UINib(nibName: "BookTallyTableViewCell", bundle: nil),
            forCellReuseIdentifier: "bookTallyTableViewCell")
        
        initData()
        refreshBookSelected()
        bookSelectTableViewHide()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        // here
    }
    
    func initData(){
        self.bookSelected = dataRepository.bookDatabase.bookData[0]
        bookSelected.part = self.dataRepository.getPartStr(bookSelected.part)
        
        if !Utility.hasCurrentUser {return}
        self.dataRepository.getBooks(Utility.currentUser, tableView: bookSelectTableView, activity: "PersonalTally")
        self.dataRepository.getBookTally(Utility.currentUser, b_id: -1, tableView: bookTallyTableView, activity: "PersonalTally")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == self.bookSelectTableView ? PersonalTallyViewController.books.count : PersonalTallyViewController.tallys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch(tableView){
            
        case self.bookSelectTableView:
            let cellIdentifier = "bookINPTableViewCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BookINPTableViewCell
            let book = PersonalTallyViewController.books[indexPath.row] as PFObject
            
            cell.bookName.text  = book["b_name"]! as? String
            var pPart_Str = [String]()
            for pPart in book["b_participant"] as! [PFObject]{pPart_Str.append(pPart["username"] as! String)}
            
            cell.bookPart.text = Utility.getStrMates(pPart_Str)
            
            let userImageFile = book["b_icon"] as! PFFile
            userImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        cell.bookIcon.image = image
                    }
                }
            }
            return cell
            
        case self.bookTallyTableView:
            let cellIdentifier = "bookTallyTableViewCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BookTallyTableViewCell
            let tally = PersonalTallyViewController.tallys[indexPath.row]
            cell.tallyTimeline.image = UIImage()
            cell.tallyTime.text      = tally.time
            cell.tallyBrief.text     = tally.brief
            cell.tallyAmount.text    = String(tally.amount)
            return cell
            
        default: return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == self.bookSelectTableView {
            if !Utility.hasCurrentUser {return}
            let book = tableView.cellForRowAtIndexPath(indexPath) as! BookINPTableViewCell
            self.bookSelected.icon = book.bookIcon.image
            self.bookSelected.name = book.bookName.text!
            self.bookSelected.part = book.bookPart.text!
            refreshBookSelected()
            bookSelectTableViewHide()
            let bookObject = PersonalTallyViewController.books[indexPath.row] as PFObject
            self.dataRepository.getBookTally(Utility.currentUser, b_id: bookObject["b_id"] as! Int, tableView: bookTallyTableView, activity: "PersonalTally")
            //bookTallyTableView.reloadData()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches as Set<UITouch>, withEvent: event)
        if !Utility.hasCurrentUser {return}
        if let touch: UITouch = touches.first! {
            let nodeTouched = touch.view
            if nodeTouched == self.bookSelectedView {
                if self.bookSelectTableView.hidden {
                    self.dataRepository.getBooks(Utility.currentUser, tableView: bookSelectTableView, activity: "PersonalTally")
                    //bookSelectTableView.reloadData()
                    bookSelectTableViewShow()}
                else {bookSelectTableViewHide()}
            }
        }
    }
    
    func bookSelectTableViewShow(){
        self.bookSelectTableView.hidden = false
        bookSelectionArrow.image = arrowUp
    }
    func bookSelectTableViewHide(){
        self.bookSelectTableView.hidden = true
        bookSelectionArrow.image = arrowDown
    }
    
    func refreshBookSelected(){
        self.pageTitle.title = bookSelected.name + " Tally"
        self.bookSelectedIcon.image = bookSelected.icon
        self.bookSelectedName.text  = bookSelected.name
        self.bookSelectedPart.text  = bookSelected.part
        self.bookSelectedIcon.layer.cornerRadius = self.bookSelectedIcon.frame.size.width/3
        self.bookSelectedIcon.layer.masksToBounds = true
    }
}

