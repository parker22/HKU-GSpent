//
//  BookMemberSelectionTableViewController.swift
//  GSpent
//
//  Created by Jiahe Liu on 9/12/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//

import UIKit
import Parse

protocol sendBookMemberBack
{
    func sendMemberToPreviousVC(selectedMembers: [PFObject])
    
}
class BookMemberSelectionTableViewController: UITableViewController {
    var mDelegate:sendBookMemberBack?
    var selectedMemberIDs = [Int]()
    let USER_NUMBER=50
    
//    var p_ids = [Int]()
    var allUsers=[PFObject]()
    var allUsersNames:[String]=[]
    var allUsersAvatars:[UIImage]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
//        for var i=0;i<USER_NUMBER;i++ {
//            p_ids.append(i)
//        }
        
        let query = PFQuery(className: "_User")
//        query.whereKey("u_id", containedIn: p_ids)
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil{
                self.allUsers = objects!
                self.tableView.reloadData()
            }
            else{
                print("Error: \(error!)")
            }
        }
//        do { allUsers += try query.findObjects() }
//        catch {print("Master indicated me to do nothing.")}
//        
//        for var i=0;i<USER_NUMBER;i++ {
//            allUsersNames[i]=allUsers[i]["username"] as! String
//            
//            let userImageFile = allUsers[i]["image"] as! PFFile
//            userImageFile.getDataInBackgroundWithBlock {
//                (imageData: NSData?, error: NSError?) -> Void in
//                if error == nil {
//                    if let imageData = imageData {
//                        self.allUsersAvatars[i] = UIImage(data:imageData)!
//                    }
//                }
//            }
//        }
        
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
        return allUsers.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookMemberSelectionCellIdentifier", forIndexPath: indexPath) as! SelectionSingleMemberTVCell
        
        //         Configure the cell...
        let user = allUsers[indexPath.row]
        cell.NameLabel.text = user["username"] as? String
        if user["u_icon"] != nil{
            let userImageFile = user["u_icon"] as! PFFile
            userImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data: imageData)
                        cell.MemberAvatar.image = image
                    }
                }
            }

        }
        
//        cell.MemberAvatar.image=allUsersAvatars[indexPath.row]
        
        self.tableView.sizeToFit()
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if (cell?.accessoryType == UITableViewCellAccessoryType.Checkmark){
            self.selectedMemberIDs = self.selectedMemberIDs.filter(){$0 != indexPath.row}
            cell!.accessoryType = UITableViewCellAccessoryType.None
            
        }else{
            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
            self.selectedMemberIDs.append(indexPath.row)
            
        }
        
//
    }
    
    
    
    @IBAction func submitBookMember(sender: AnyObject) {
        var members = [PFObject]()
        for id in selectedMemberIDs{
            members.append(allUsers[id])
        }
        print(members)
        sendMemberToPreviousVC(members)
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    func sendMemberToPreviousVC(selectedMembers: [PFObject]){
        self.mDelegate?.sendMemberToPreviousVC(selectedMembers)
        
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
