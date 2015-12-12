//
//  NewBookViewController.swift
//  GSpent
//
//  Created by HUI ZHAN on 12/2/15.
//  Copyright © 2015 LIU Jiahe. All rights reserved.
//

import UIKit
import Parse

class NewBookViewController: UIViewController,sendBookMemberBack {
    
    var members:[Int]=[]
    var membersID = Dictionary<String, String>()
    
    @IBOutlet weak var selectBookMemberBtn: UIButton!

    @IBOutlet weak var cancelAddBook: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitNewBook(sender: AnyObject) {
        //do some thing
        var newBook = PFObject(className:"Book")
//        var participantsObject:[PFObject]=[{"__type":"Pointer","className":"_User","objectId":"DfOI3qgAh9"},{"__type":"Pointer","className":"_User","objectId":"ZaN8ROytUA"}]
        
        newBook["b_average"] = 1000
        newBook["u_id"] = 9996
        //newBook["ACL"] = "Public Read + Write"//ACL
        newBook["b_icon"] = PFFile(data:UIImagePNGRepresentation(UIImage(named: "bookAvatarDefault")!)!)//File
        if members.count == 0{
            //popup a window : please select member
            let alertController = UIAlertController(title: "No Member", message: "You didn't select a single member, please specify at least one member", preferredStyle: .Alert)
//            
//            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action:UIAlertAction!) in
//                print("you have pressed the Cancel button");
//            }
//            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
                print("you have pressed OK button");
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true, completion:nil)
            //return
        }
        
        
        
        newBook["b_name"]="HKU CS 3"
        newBook["b_participant"] = [PFObject]()//Array {"objectId":"DfOI3qgAh9"}
        newBook["b_id"]=1000
        
        newBook.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("uploaded successfully");
                self.dismissViewControllerAnimated(true, completion: nil);// The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
        
    }
    
    
    @IBAction func cancelAddBook(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);

    }
    
    
    @IBAction func chooseMembers(sender: AnyObject) {
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "bookMemberSelectionIdentifier" {
            let memberSelectionViewController = segue.destinationViewController as! BookMemberSelectionTableViewController
            memberSelectionViewController.mDelegate = self
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
            
        }
    }
    
    
    func sendMemberToPreviousVC(selectedMemberIDs: [Int]) {
        selectBookMemberBtn.setTitle("已选择成员"+selectedMemberIDs.description, forState: UIControlState.Normal)
        print(selectedMemberIDs)
    }
    
    
}
