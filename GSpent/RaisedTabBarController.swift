//
//  RaisedTabBarController.swift
//  GSpent
//
//  Created by Jiahe Liu on 29/11/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//

import UIKit

class RaisedTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
    internal func insertEmptyTabItem(title: String, atIndex: Int) {
        let vc = UIViewController()
        vc.tabBarItem = UITabBarItem(title: title, image: nil, tag: 0)
        vc.tabBarItem.enabled = false
        
        self.viewControllers?.insert(vc, atIndex: atIndex)
    }
    
    internal func addRaisedButton(buttonImage: UIImage?, highlightImage: UIImage?) {
        if let buttonImage = buttonImage {
            let button = UIButton(type: UIButtonType.Custom)
            button.autoresizingMask = [UIViewAutoresizing.FlexibleRightMargin, UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleBottomMargin, UIViewAutoresizing.FlexibleTopMargin]
            
            button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height)
            button.setBackgroundImage(buttonImage,    forState: UIControlState.Normal)
            button.setBackgroundImage(highlightImage, forState: UIControlState.Highlighted)
            
            let heightDifference = buttonImage.size.height - self.tabBar.frame.size.height
            
            if (heightDifference < 0) {
                button.center = self.tabBar.center
            }
            else {
                var center = self.tabBar.center
                center.y -= heightDifference / 2.0
                button.center = center
            }
            
            button.addTarget(self, action: "onRaisedButton:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(button)
        }
    }
    
    internal func onRaisedButton(sender: UIButton!) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
