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
    
    //var members:[Int]=[]
    var participantsObjects = [PFObject]()
    
    @IBOutlet weak var selectBookMemberBtn: UIButton!

    @IBOutlet weak var newBookNameTF: UITextField!
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
        
//        newBook["b_average"] = 1000
        newBook["u_id"] = 9996
        newBook["b_icon"] = PFFile(data:UIImagePNGRepresentation(UIImage(named: "bookAvatarDefault")!)!)//File
        if participantsObjects.count == 0{
            //popup a window : please select member
            let alertController = UIAlertController(title: "No Member", message: "You didn't select a single member, please specify at least one member", preferredStyle: .Alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
                print("you have pressed OK button");
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true, completion:nil)
            return
        }
        if self.newBookNameTF.text==""{
            //popup a window : please select member
            let alertController = UIAlertController(title: "No Name", message: "You didn't name your book, please specify a name", preferredStyle: .Alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
                print("you have pressed OK button");
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true, completion:nil)
            return
        }
        newBook["b_name"]=self.newBookNameTF.text
        self.participantsObjects.append(Utility.currentUser)
        newBook["b_participant"] = participantsObjects
        newBook["b_id"]=1000
        
        newBook.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("uploaded successfully");
                self.navigationController?.popViewControllerAnimated(true)
                self.dismissViewControllerAnimated(true, completion: nil)// The object has been saved.
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
    
    
    func sendMemberToPreviousVC(selectedMembers: [PFObject]) {
        selectBookMemberBtn.setTitle("已选择成员", forState: UIControlState.Normal)
        print(selectedMembers)
        
//        let query = PFQuery(className: "_User")
//        query.whereKey("u_id", containedIn: selectedMemberIDs)
//        do { participantsObjects += try query.findObjects() }
//        catch {print("didnt find object")}
        participantsObjects = selectedMembers
    }
    
    
}
