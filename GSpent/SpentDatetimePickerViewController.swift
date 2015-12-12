//
//  SpentDatetimePickerViewController.swift
//  GSpent
//
//  Created by HUI ZHAN on 12/12/15.
//  Copyright © 2015 LIU Jiahe. All rights reserved.
//

import UIKit

protocol sendSpentDateBack
{
    func sendDateToPreviousVC(date: NSDate)
    
}


class SpentDatetimePickerViewController: UIViewController {
    var mDelegate:sendSpentDateBack?
    
    @IBOutlet weak var datetimePicker: UIDatePicker!
    @IBOutlet weak var pickerDetermine: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func determineTime(sender: AnyObject) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        var strDate = dateFormatter.stringFromDate(datetimePicker.date)
        sendDateToPreviousVC(datetimePicker.date)
    }
    
    func sendDateToPreviousVC(date: NSDate){
        self.mDelegate?.sendDateToPreviousVC(date)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
