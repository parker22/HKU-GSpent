//
//  BookTableViewController.swift
//  GSpent
//
//  Created by Jiahe Liu on 29/11/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//
import Parse
import UIKit



class BookTableViewController: UITableViewController,RefreshBookTableViewControllerDelegate {
    
    
    @IBAction func RefreshBookList(sender: AnyObject) {
        self.initData()
        self.bookListTV.reloadData()
        self.refreshControl?.endRefreshing()
    }
    @IBOutlet var bookListTV: UITableView!
    var books = [Book]()
    static var bookData = [PFObject]()
    static var relationData = [PFObject]()
    
    var dataRepository = DataRepository()
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        Utility.mDelegate = self
        self.initData()
        //        books = self.dataRepository.getBooks()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        //        tableView.registerNib(UINib(nibName: "bookTableViewCell", bundle: nil), forCellReuseIdentifier: "bookTableViewCell")
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    //    func refresh(sender:AnyObject)
    //    {
    //        // Updating your data here...
    //
    //        self.bookListTV.reloadData()
    //        self.refreshControl?.endRefreshing()
    //    }
    
    override func viewWillAppear(animated: Bool) {
        let selectedIndex = self.tableView.indexPathForSelectedRow
        if (selectedIndex != nil) {
            self.bookListTV.deselectRowAtIndexPath(selectedIndex!, animated: animated)
        }
    }
    
    func initData(){
        if Utility.hasCurrentUser{
            print(Utility.currentUser)
            self.dataRepository.bookDatabase.getBookPFObjects(Utility.currentUser, tableView: self.bookListTV, activity: "BookList" )
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return BookTableViewController.bookData.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //        let cell:bookTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("bookTableViewCell") as! bookTableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("bookListTblViewCell", forIndexPath: indexPath) as! bookTableViewCell
        //        let book = books[indexPath.row]
        let book = BookTableViewController.bookData[indexPath.row]
        for relation in BookTableViewController.relationData{
            if (relation["b_id"] as? String == book.objectId){
                cell.lblBookAmount.text = relation["amount_due"].doubleValue.description
            }
        }
        //        let query = PFQuery(className:"TestObject")
        //        query.getObjectInBackgroundWithId("m7lhJgzeop") {
        //            (testObject: PFObject?, error: NSError?) -> Void in
        //            if error == nil && testObject != nil {
        //                let userImageFile = testObject!["image"] as! PFFile
        //                userImageFile.getDataInBackgroundWithBlock {
        //                    (imageData: NSData?, error: NSError?) -> Void in
        //                    if error == nil {
        //                        if let imageData = imageData {
        //                            let image = UIImage(data:imageData)
        //                            cell.imgBookAvatar.image = image
        //                        }
        //                    }
        //                }
        //
        //
        //            } else {
        //                print(error)
        //            }
        //        }
        
        
        let userImageFile = book["b_icon"] as! PFFile
        userImageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.imgBookAvatar.image = image
                }
            }
        }
        //        cell.lblBookName.text = book.name
        cell.lblBookName.text = book["b_name"] as? String
        cell.lblBookMates.text  = Utility.getStrMatesFromObjects(book["b_participant"] as! [PFObject])
        //        cell.imgBookAvatar.image = book.icon
        //        cell.lblBookMates.text  = self.dataRepository.getPartStr(book.part)
        // Configure the cell...
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //        Get the new view controller using segue.destinationViewController.
        //        Pass the selected object to the new view controller.
        if (segue.identifier=="showBookDetailIdentifier"){
            let vc = segue.destinationViewController as! BookDetailViewController
            let path = self.bookListTV.indexPathForSelectedRow?.row
            vc.book = BookTableViewController.bookData[path!]
        }
    }
    func refreshBookTableViewController() {
        initData()
    }
}
