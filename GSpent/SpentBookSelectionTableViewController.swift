//
//  SpentBookSelectionTableViewController.swift
//  GSpent
//
//  Created by Jiahe Liu on 9/12/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//

import UIKit
import Parse

protocol sendSpentBookBack
{
    func sendBookToPreviousVC(selectedBookID: Int)
    
}

class SpentBookSelectionTableViewController: UITableViewController {
    var mDelegate:sendSpentBookBack?
    var selectedBookId :Int?
    @IBOutlet var addSpentSelectBookList: UITableView!
    
    
    let b_ids = [Int]([1,3,5,6,9])
    static var books  = [PFObject]()
    let dataRepository = DataRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataRepository.getBooks(USER_ID, tableView: addSpentSelectBookList, activity: "AddSpent")
        self.addSpentSelectBookList.registerNib(UINib(nibName: "BookINPTableViewCell", bundle: nil),
            forCellReuseIdentifier: "bookINPTableViewCell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        dispatch_async(dispatch_get_main_queue()) {
            //This code will run in the main thread:
            var frame:CGRect = self.view.frame
            
            self.view.frame = CGRectMake(0,frame.size.height-self.tableView.contentSize.height,0,self.tableView.contentSize.height)
        }
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return SpentBookSelectionTableViewController.books.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "bookINPTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BookINPTableViewCell
        let book = SpentBookSelectionTableViewController.books[indexPath.row] as PFObject
        cell.bookName.text  = book["b_name"]! as? String
        var pPart_Str = [String]()
        print(book.objectId)
        print(book["b_participant"])
        for pPart in book["b_participant"] as! [PFObject]{
            print(pPart["username"])
            pPart_Str.append(pPart["username"] as! String)
        }
        
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
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedBookId = b_ids[indexPath.row]
        sendBookToPreviousVC(selectedBookId!)
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    func sendBookToPreviousVC(bookId: Int){
        self.mDelegate?.sendBookToPreviousVC(bookId)
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
