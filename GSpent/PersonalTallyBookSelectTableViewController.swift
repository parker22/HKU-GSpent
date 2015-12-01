//
//  PersonalTallyBookSelectTableViewController.swift
//  GSpent
//
//  Created by HUI ZHAN on 11/29/15.
//  Copyright © 2015 LIU Jiahe. All rights reserved.
//

import UIKit

class PersonalTallyBookSelectTableViewController: UITableViewController {
    
    var books = [BookIconNamePeople]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadBooks()
    }
    
    func loadBooks(){
        let image1 = UIImage(named: "blue_box")!
        
        let book1 = BookIconNamePeople(icon: image1, name: "haha", people: "nobody")!
        let book2 = BookIconNamePeople(icon: image1, name: "hehe", people: "somebody")!
        let book3 = BookIconNamePeople(icon: image1, name: "xixi", people: "anybody")!
        
        books += [book1, book2, book3]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "BookIconNamePeople"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BookINPTableViewCell
        
        let book = books[indexPath.row]
        
        cell.bookIcon.image = book.bookIcon
        cell.bookName.text = book.bookName
        cell.bookPeople.text = book.bookPeople

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
