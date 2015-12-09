//
//  NewBookViewController.swift
//  GSpent
//
//  Created by HUI ZHAN on 12/2/15.
//  Copyright © 2015 LIU Jiahe. All rights reserved.
//

import UIKit

class NewBookViewController: UIViewController,sendBookMemberBack {
    
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
    }
    @IBAction func cancelAddBook(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);

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
