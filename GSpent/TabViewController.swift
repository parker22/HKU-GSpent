//
//  TabViewController.swift
//  GSpent
//
//  Created by Jiahe Liu on 29/11/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//

import UIKit

class TabViewController: RaisedTabBarController {

    @IBOutlet var addBook:  UIButton!
    @IBOutlet var addSpent: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addBook = UIButton(frame: CGRect(x: 100, y: 630, width: 50, height: 50))
        addBook.setImage(UIImage(named: "bookIconSample00"), forState: UIControlState.Normal)
        addBook.titleLabel?.font = UIFont.boldSystemFontOfSize(30)
        addBook.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        //addBook.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        addBook.setTitle("图片按钮", forState: UIControlState.Normal)
        self.view.addSubview(addBook)
        addBook.addTarget(self, action: Selector("addBook:"), forControlEvents: UIControlEvents.TouchUpInside)
        addBook.hidden = true
        
        addSpent = UIButton(frame: CGRect(x: 264, y: 630, width: 50, height: 50))
        addSpent.setImage(UIImage(named: "bookIconSample00"), forState: UIControlState.Normal)
        addSpent.titleLabel?.font = UIFont.boldSystemFontOfSize(30)
        addSpent.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        //addSpent.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        addSpent.setTitle("图片按钮", forState: UIControlState.Normal)
        self.view.addSubview(addSpent)
        addSpent.addTarget(self, action: Selector("addSpent:"), forControlEvents: UIControlEvents.TouchUpInside)
        addSpent.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Insert empty tab item at center index. In this case we have 5 tabs.
        self.insertEmptyTabItem("", atIndex: 1)
        
        // Raise the center button with image
        let img = UIImage(named: "tabbar_item_new_spent")
        self.addRaisedButton(img, highlightImage: nil)
    }
    
    // Handler for raised button
    override func onRaisedButton(sender: UIButton!) {
        //performSegueWithIdentifier("showNewSpentSegue", sender: self)
        
        if (self.addBook.hidden&&self.addSpent.hidden){
            self.addBook.hidden  = false
            self.addSpent.hidden = false
        } else {
            self.addBook.hidden  = true
            self.addSpent.hidden = true
        }
        
        print("Raised button tapped")
    }
    
    func addBook(sender: UIButton!){
        performSegueWithIdentifier("showNewBookSegue", sender: self)
    }
    
    func addSpent(sender: UIButton!){
        performSegueWithIdentifier("showNewSpentSegue", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//        segue.destinationViewController = NewSpentViewController
        if (segue.identifier == "showNewSpentSegue") {
            
        }
    }
    

}
