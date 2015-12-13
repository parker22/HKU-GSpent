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
    func sendBookToPreviousVC(selectedBook: PFObject)
    
}

class SpentBookSelectionTableViewController: UITableViewController {
    var mDelegate:sendSpentBookBack?
    var selectedBook :PFObject?
    @IBOutlet var addSpentSelectBookList: UITableView!
    
    static var books  = [PFObject]()
    let dataRepository = DataRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !Utility.hasCurrentUser {return}
        dataRepository.getBooks(Utility.currentUser, tableView: addSpentSelectBookList, activity: "AddSpent")
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
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedBook = SpentBookSelectionTableViewController.books[indexPath.row]
        sendBookToPreviousVC(selectedBook!)
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    func sendBookToPreviousVC(book: PFObject){
        self.mDelegate?.sendBookToPreviousVC(book)
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
