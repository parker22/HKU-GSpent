//
//  bookPopoverViewController.swift
//  GSpent
//
//  Created by Jiahe Liu on 4/12/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//

import UIKit

class bookPopoverViewController: UITableViewController{

    @IBOutlet var bookPopoverTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = SettlementViewController()
        self.presentViewController(vc, animated: true, completion: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    

}
