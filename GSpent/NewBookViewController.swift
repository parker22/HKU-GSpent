//
//  NewBookViewController.swift
//  GSpent
//
//  Created by HUI ZHAN on 12/2/15.
//  Copyright © 2015 LIU Jiahe. All rights reserved.
//

import UIKit

class NewBookViewController: UIViewController {
    
    @IBOutlet weak var cancel: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
}
