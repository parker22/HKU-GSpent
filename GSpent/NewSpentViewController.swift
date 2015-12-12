//
//  NewSpentViewController.swift
//  GSpent
//
//  Created by Jiahe Liu on 28/11/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//
import Parse
import UIKit

class NewSpentViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIPopoverPresentationControllerDelegate,sendSpentBookBack,sendSpentDateBack,sendPictureBack{
    
    
    @IBOutlet weak var spentBookSelectionBtn: UIButton!
    @IBOutlet weak var addSpentDescription: UIBarButtonItem!
    @IBOutlet weak var cancelAddSpent: UIBarButtonItem!
    @IBOutlet weak var spentCategoryCV: UICollectionView!
    @IBOutlet weak var spendAmount: UITextField!
    
    var categories = [Category]()
    var dataRepository = DataRepository()
    
    //var tallyId: Int
    var brief:   String!
    var user:    PFObject!
    var userId:  Int!
    var book:    PFObject!
    var bookId:  Int!
    var picture: UIImage?
    var time:    NSDate!
    var typeId:  Int!
    var amount:  Double!

    
    let spentCategoryCellIdentifier = "spentCategoryCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spentCategoryCV.delegate = self
        spentCategoryCV.dataSource = self
        spentCategoryCV.allowsSelection = true
        categories = self.dataRepository.getCategory()
        brief = ""
        amount = 0.00
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAddSpent(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
        
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = spentCategoryCV.dequeueReusableCellWithReuseIdentifier(spentCategoryCellIdentifier, forIndexPath: indexPath) as! spentCategoryCollectionViewCell
        cell.categoryIcon.image = categories[indexPath.row].icon
        cell.categoryName.text = categories[indexPath.row].name
        
        return cell
    }
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.spentCategoryCV.cellForItemAtIndexPath(indexPath)?.backgroundColor = UIColor.greenColor()
        typeId = indexPath.item+1
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath){
        self.spentCategoryCV.cellForItemAtIndexPath(indexPath)?.backgroundColor = UIColor.whiteColor()
    }
    
    @IBAction func addSpentDescription(sender: AnyObject) {
        let alertController = UIAlertController(title: "钱是怎么花的?", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.borderStyle = UITextBorderStyle.None
            textField.autoresizingMask = UIViewAutoresizing.FlexibleHeight
            textField.font = UIFont.systemFontOfSize(20)
            textField.text = self.brief
            textField.placeholder = "怎么花的..."
        }
        
        let okAction = UIAlertAction(title: "写好了", style: UIAlertActionStyle.Default) {
            (action: UIAlertAction!) -> Void in
            let textBox = (alertController.textFields?.first)! as UITextField
            print(textBox.text)
            self.brief = textBox.text
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion:{})
    }
    
    @IBAction func addSpentDatetime(sender: AnyObject) {
        
    }
    
    @IBAction func submitNewSpent(sender: AnyObject) {
        if(bookId == nil) {
            let alert = UIAlertController(title: "Choose a book", message: "Please choose a book before submit your spent.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        if(typeId == nil) {
            let alert = UIAlertController(title: "Choose a type", message: "Please choose a type before submit your spent.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        brief = brief == "" ? "No event." : brief
        userId = USER_ID
        time = time == nil ? NSDate() : time
        amount = spendAmount.text! == "" ? amount : Double(spendAmount.text!)
        
        let userQuery = PFQuery(className: "_User")
        userQuery.whereKey("u_id", equalTo: userId)
        do { user = try userQuery.findObjects()[0] }
        catch {print("Master indicated me to do nothing.")}
        
        let bookQuery = PFQuery(className: "Book")
        bookQuery.whereKey("b_id", equalTo: bookId)
        do { book = try bookQuery.findObjects()[0] }
        catch {print("Master indicated me to do nothing.")}
        
        dataRepository.addSpent(brief, user: user, u_id: userId, book: book, b_id: bookId, t_pic: picture, t_time: time, t_type: typeId, t_amount: amount)
        
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "spentDatetimePopoverIdentifier" {
            let popoverViewController = segue.destinationViewController as! SpentDatetimePickerViewController
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
            popoverViewController.mDelegate = self
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
            
        }
        if segue.identifier == "spentBookSelectionIdentifier" {
            let bookSelectionViewController = segue.destinationViewController as! SpentBookSelectionTableViewController
            bookSelectionViewController.mDelegate = self
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
            
        }
        if segue.identifier == "spentPictureAttachIdentifier" {
            let takePicViewController = segue.destinationViewController as! TakePicViewController
            takePicViewController.mDelegate = self
            takePicViewController.spentImage = picture
        }
    }
    
    func sendBookToPreviousVC(selectedBookID: Int) {
        print(selectedBookID)
        self.bookId = selectedBookID
        spentBookSelectionBtn.setTitle("已选择账本: "+String(selectedBookID), forState: UIControlState.Normal)
    }
    
    func sendDateToPreviousVC(date: NSDate){
        self.time = date
    }
    
    func sendpictureToPreviousVC(spentPic: UIImage){
        self.picture = spentPic
    }
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
}
