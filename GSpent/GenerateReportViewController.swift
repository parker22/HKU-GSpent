//
//  SettlementViewController.swift
//  GSpent
//
//  Created by Laurence on 3/12/2015.
//  Copyright © 2015 LIU Jiahe. All rights reserved.
//

import UIKit

class GenerateReportViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //
    
    
    @IBOutlet var outputValue: UILabel!
    
    @IBOutlet weak var settleTV: UITableView!
    @IBAction func genetation(sender: AnyObject) {
        //outputValue.text=relationships.toString()
        
    }
    let relationships=AllOweingRelationships.init()
    
    @IBAction func share(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settleTV.delegate = self
        settleTV.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //write some code to control the cell here
        var returnableCell :UITableViewCell
        if indexPath.row == 0 {
            
            let cell:NameCell = tableView.dequeueReusableCellWithIdentifier("SettlementNameList") as! NameCell
            cell.NameLabel.text = relationships.allDebtors()[indexPath.section]
            returnableCell = cell
        }
        else {
           let cell:RecordCell = tableView.dequeueReusableCellWithIdentifier("SettlementSingleOweRecord")! as! RecordCell
            var certainPerson:String
            certainPerson=relationships.allDebtors()[indexPath.section]
            let records:[OweRecord]=relationships.recordsRelatedToCertainDebtor(who: certainPerson)
            
            cell.recordLabel.text = records[indexPath.row].toHalfString()
            returnableCell = cell
        }
        return returnableCell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        let num=relationships.allCreditors().count
        return num
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var certainPerson:String
        certainPerson=relationships.allDebtors()[section]
        let records:[OweRecord]=relationships.recordsRelatedToCertainDebtor(who: certainPerson)
        return records.count
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
