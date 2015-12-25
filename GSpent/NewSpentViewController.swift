//
//  NewSpentViewController.swift
//  GSpent
//
//  Created by Jiahe Liu on 28/11/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//
import Parse
import UIKit

class NewSpentViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIPopoverPresentationControllerDelegate,UITextFieldDelegate ,sendSpentBookBack,sendSpentDateBack,sendPictureBack{
    
    
    @IBOutlet weak var spentBookSelectionBtn: UIButton!
    @IBOutlet weak var addSpentDescription: UIBarButtonItem!
    @IBOutlet weak var cancelAddSpent: UIBarButtonItem!
    @IBOutlet weak var spentCategoryCV: UICollectionView!
    @IBOutlet weak var spendAmount: UITextField!
    @IBOutlet weak var addSpentConfirm: UIButton!
    @IBOutlet weak var inputAmount: UIView!
    
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
        self.spendAmount.delegate = self
        brief  = ""
        amount = 0.00
        Utility.addButtonStyle(addSpentConfirm, border: 2, radius: 5, textColor: Utility.colorWithHexString(colorPrimary[4]), borderColor: Utility.colorWithHexString(colorPrimary[4]))
        Utility.addButtonStyle(spentBookSelectionBtn, border: 2, radius: 5, textColor: Utility.colorWithHexString(colorPrimary[4]), borderColor: Utility.colorWithHexString(colorPrimary[4]))
        //Utility.addBorder(inputAmount, border: 2, radius: 5, color: Utility.colorWithHexString(colorPrimary[4]))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()}
    
    @IBAction func cancelAddSpent(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)}
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count}
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = spentCategoryCV.dequeueReusableCellWithReuseIdentifier(spentCategoryCellIdentifier, forIndexPath: indexPath) as! spentCategoryCollectionViewCell
        cell.categoryIcon.image = categories[indexPath.row].icon
        cell.categoryName.text  = categories[indexPath.row].name
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = self.spentCategoryCV.cellForItemAtIndexPath(indexPath) as! spentCategoryCollectionViewCell
        Utility.addBorder(cell.categoryIcon, border: 3, radius: 30, color: Utility.colorWithHexString(colorPrimary[4]))
        self.typeId = indexPath.item+1
        
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath){
        let cell = self.spentCategoryCV.cellForItemAtIndexPath(indexPath) as! spentCategoryCollectionViewCell
        Utility.addBorder(cell.categoryIcon, border: 3, radius: 30, color: UIColor.clearColor())
    }
    
    @IBAction func addSpentDescription(sender: AnyObject) {
        let alertController = UIAlertController(title: "Spent brief", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.borderStyle = UITextBorderStyle.None
            textField.autoresizingMask = UIViewAutoresizing.FlexibleHeight
            textField.font = UIFont.systemFontOfSize(20)
            textField.text = self.brief
            textField.placeholder = "Spent item1, item2 ..."
        }
        
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default) {
            (action: UIAlertAction!) -> Void in
            let textBox = (alertController.textFields?.first)! as UITextField
            print(textBox.text)
            self.brief = textBox.text
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion:{})
    }
    
    @IBAction func addSpentDatetime(sender: AnyObject) {
        
    }
    
    @IBAction func submitNewSpent(sender: AnyObject) {
        if !Utility.hasCurrentUser {return}
        
        if(book == nil) {
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
        
        brief  = brief == "" ? "No event." : brief
        user   = Utility.currentUser
        userId = user["u_id"].integerValue
        time   = time == nil ? NSDate() : time
        amount = spendAmount.text! == "" ? amount : Double(spendAmount.text!)
        
        let userQuery = PFQuery(className: "_User")
        userQuery.whereKey("u_id", equalTo: userId)
        do { user = try userQuery.findObjects()[0] }
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
    
    func sendBookToPreviousVC(selectedBook: PFObject) {
        self.book = selectedBook
        self.bookId = self.book["b_id"].integerValue
        spentBookSelectionBtn.setTitle("Target Book: "+String(self.book["b_name"]), forState: UIControlState.Normal)
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
