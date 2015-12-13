//
//  BookDetailViewController.swift
//  GSpent
//
//  Created by Jiahe Liu on 2/12/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//

import UIKit
import Parse

class BookDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate {

    
    @IBOutlet weak var bookMemberCV: UICollectionView!
    @IBOutlet weak var bookMemberSelected: UIImageView!
    @IBOutlet weak var bookTallyTV: UITableView!
    
    @IBOutlet weak var bookTotalAmountLbl: UILabel!
    
    
    static var totalAmount:Double = 0.0
    
    
    var members = [Person]()
    static var tallys = [PFObject]()
    var book: PFObject!
    var dataRepository = DataRepository()
    
    let bookMemberCellIdentifier = "bookMemberCell"
    let bookTallyCellIdentifier = "bookTallyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookTotalAmountLbl.text = BookDetailViewController.totalAmount.description
        bookMemberCV.delegate = self
        bookMemberCV.dataSource = self
        bookTallyTV.delegate = self
        bookTallyTV.dataSource = self
        // Do any additional setup after loading the view.
        members = self.dataRepository.getPersons()
        bookMemberSelected.layer.cornerRadius = bookMemberSelected.frame.size.width/2
        bookMemberSelected.clipsToBounds = true
        bookMemberSelected.image = members[0].avatar
        self.dataRepository.tallyDatabase.getBookDetailTally(Utility.currentUser, book: book, tableView: self.bookTallyTV, activity: "getBookDetailTally")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = bookMemberCV.dequeueReusableCellWithReuseIdentifier(bookMemberCellIdentifier, forIndexPath: indexPath) as! bookMemberCollectionViewCell
        cell.bookMemberAvatar.image = members[indexPath.row].avatar
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        bookMemberSelected.image = members[indexPath.row].avatar
    }
    
    
    
    //the tabelview displaying detailed tally list for each person
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        return
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tally = BookDetailViewController.tallys[indexPath.row]
        print(tally)
        let cell:bookDetailTallyTableViewCell = bookTallyTV.dequeueReusableCellWithIdentifier(bookTallyCellIdentifier, forIndexPath: indexPath) as! bookDetailTallyTableViewCell
        cell.bookTallyAvatarIV.image = members[indexPath.row].avatar
        cell.bookTallyDescriptionLbl.text = tally["t_brief"] as? String
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let time = dateFormatter.stringFromDate(tally["t_time"] as! NSDate)
        cell.bookTallyDatetimeLbl.text = time
        let t_amount = tally["t_amount"].doubleValue
        
        self.bookTotalAmountLbl.text = BookDetailViewController.totalAmount.description
        cell.bookTallyAmountLbl.text = String(t_amount)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookDetailViewController.tallys.count
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "bookPopoverIdentifier" {
            let popoverViewController = segue.destinationViewController
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
            
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
