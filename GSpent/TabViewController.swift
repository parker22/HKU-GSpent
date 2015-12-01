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
        // Insert empty tab item at center index. In this case we have 5 tabs.
                self.insertEmptyTabItem("", atIndex: 1)
        //
        //        // Raise the center button with image
                let img = UIImage(named: "tabbar_item_new_spent")
                self.addRaisedButton(img, highlightImage: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        // Insert empty tab item at center index. In this case we have 5 tabs.
//        self.insertEmptyTabItem("", atIndex: 1)
//        
//        // Raise the center button with image
//        let img = UIImage(named: "add")
//        self.addRaisedButton(img, highlightImage: nil)
//    }
    
    // Handler for raised button
    override func onRaisedButton(sender: UIButton!) {
//        super.onRaisedButton(sender)
        performSegueWithIdentifier("showNewSpentSegue", sender: self)
        print("Raised button tapped")
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
