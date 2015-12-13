//
//  SettlementViewController.swift
//  GSpent
//
//  Created by Laurence on 3/12/2015.
//  Copyright © 2015 LIU Jiahe. All rights reserved.
//

import UIKit

class SettlementViewController: UIViewController {
    
    @IBAction func generateSettlement(sender: AnyObject) {
        var person1s = [String]()
        var person2s = [String]()
        
        let str = "{\"books\": [\"person1\", \"person2\", \"person3\"]}"
        let nsData = str.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        //TODO:obtain server NSData here...
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(nsData,options: .AllowFragments)
            
            if let books = json["books"] as? [[String: AnyObject]] {
                for book in books {
                    if let person = book["person1"] as? String {
                        person1s.append(person)
                    }
                    if let person = book["person2"] as? String {
                        person2s.append(person)
                    }
                }
            }
            
        } catch {
            print("error reading JSON data: \(error)")
        }
        
        print(person1s) // ["Bloxus test", "Manila Test"]
    }
    
    @IBAction func share(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
