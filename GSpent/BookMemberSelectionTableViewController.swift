//
//  BookMemberSelectionTableViewController.swift
//  GSpent
//
//  Created by Jiahe Liu on 9/12/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//

import UIKit

protocol sendBookMemberBack
{
    func sendMemberToPreviousVC(selectedMemberIDs: [Int])
    
}
class BookMemberSelectionTableViewController: UITableViewController {
    var mDelegate:sendBookMemberBack?
    var selectedMemberIDs = [Int]()
    
    let p_ids = [Int]([1,3,5,6,7,66,323,21])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return p_ids.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookMemberSelectionCellIdentifier", forIndexPath: indexPath)
        
        //         Configure the cell...
        cell.textLabel?.text = p_ids[indexPath.row].description
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if (cell?.accessoryType == UITableViewCellAccessoryType.Checkmark){
            self.selectedMemberIDs = self.selectedMemberIDs.filter(){$0 != p_ids[indexPath.row]}
            cell!.accessoryType = UITableViewCellAccessoryType.None
            
        }else{
            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
            print(p_ids[indexPath.row])
            self.selectedMemberIDs.append(p_ids[indexPath.row])
            
        }
        print(selectedMemberIDs)
        
        
//
    }
    
    
    
    @IBAction func submitBookMember(sender: AnyObject) {
        sendMemberToPreviousVC(selectedMemberIDs)
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    func sendMemberToPreviousVC(selectedMemberIDs: [Int]){
        self.mDelegate?.sendMemberToPreviousVC(selectedMemberIDs)
        
    }


    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
