//
//  TabViewController.swift
//  GSpent
//
//  Created by Jiahe Liu on 29/11/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//
import UIKit

class TabViewController: RaisedTabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utility.getCurrentUser()
        self.insertEmptyTabItem("", atIndex: 1)
        let img = UIImage(named: "tabbar_item_new_spent")
        self.addRaisedButton(img, highlightImage: nil)

//        addBook = UIButton(frame: CGRect(x: 100, y: 630, width: 50, height: 50))
//        addBook.setImage(UIImage(named: "bookIconSample00"), forState: UIControlState.Normal)
//        addBook.titleLabel?.font = UIFont.boldSystemFontOfSize(30)
//        addBook.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
//        //addBook.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        addBook.setTitle("add a new book", forState: UIControlState.Normal)
//        addBook.addTarget(self, action: Selector("addBook:"), forControlEvents: UIControlEvents.TouchUpInside)
//        addBook.hidden = true
//        self.view.addSubview(addBook)
//        
//        addSpent = UIButton(frame: CGRect(x: 264, y: 630, width: 50, height: 50))
//        addSpent.setImage(UIImage(named: "bookIconSample00"), forState: UIControlState.Normal)
//        addSpent.titleLabel?.font = UIFont.boldSystemFontOfSize(30)
//        addSpent.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
//        //addSpent.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        addSpent.setTitle("add a new spent", forState: UIControlState.Normal)
//        addSpent.addTarget(self, action: Selector("addSpent:"), forControlEvents: UIControlEvents.TouchUpInside)
//        addSpent.hidden = true
//        self.view.addSubview(addSpent)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func onRaisedButton(sender: UIButton!) {
//        let ifHide = self.addBook.hidden&&self.addSpent.hidden
//        if (ifHide){ extraButtonSetShow() }
//        else       { extraButtonSetHide() }
        performSegueWithIdentifier("showNewSpentSegue", sender: self)
//        print("Raised button tapped")
    }

//    func addBook (sender: UIButton!){
//        extraButtonSetHide()
//        performSegueWithIdentifier("showNewBookSegue",  sender: self)
//    }
    
//    func addSpent(sender: UIButton!){
//        extraButtonSetHide()
//        performSegueWithIdentifier("showNewSpentSegue", sender: self)
//    }
    
//    func extraButtonSetShow(){
//        self.addBook.hidden  = false
//        self.addSpent.hidden = false
//    }
//    
//    func extraButtonSetHide(){
//        self.addBook.hidden  = true
//        self.addSpent.hidden = true
//    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // segue.destinationViewController = NewSpentViewController
        if (segue.identifier == "showNewSpentSegue") {
            
        }
    }
    

}
