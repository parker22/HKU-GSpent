//
//  NewSpentViewController.swift
//  GSpent
//
//  Created by Jiahe Liu on 28/11/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//
import Parse
import UIKit


class NewSpentViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIPopoverPresentationControllerDelegate{
    
    
    @IBOutlet weak var addSpentDescription: UIBarButtonItem!
    @IBOutlet weak var cancelAddSpent: UIBarButtonItem!
    
    @IBOutlet weak var spentCategoryCV: UICollectionView!
    var categories = [Category]()
    var dataRepository = DataRepository()
    let spentCategoryCellIdentifier = "spentCategoryCellIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()
        spentCategoryCV.delegate = self
        spentCategoryCV.dataSource = self
        categories = self.dataRepository.getCategory()
        spentCategoryCV.allowsSelection = true
        
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
        
    }
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        self.spentCategoryCV.cellForItemAtIndexPath(indexPath)?.backgroundColor = UIColor.whiteColor()
    }
    
    @IBAction func addSpentDescription(sender: AnyObject) {
        let alertController = UIAlertController(title: "钱是怎么花的?", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
//        let customView =  spentDescriptionTextFieldView(frame: CGRectMake(0, 0, self.view.frame.width, 80))
//        alertController.view.addSubview(customView)
//        let picker = UIDatePicker
//        picker.
//        UIDatePickerMode.DateAndTime
        
        alertController.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.borderStyle = UITextBorderStyle.None
            textField.autoresizingMask = UIViewAutoresizing.FlexibleHeight
            textField.font = UIFont.systemFontOfSize(20)
            
            textField.placeholder = "怎么花的..."
            
            
        }
        
        let okAction = UIAlertAction(title: "写好了", style: UIAlertActionStyle.Default) {
            (action: UIAlertAction!) -> Void in
            let login = (alertController.textFields?.first)! as UITextField
            print(login.text)
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion:{})
        
    }
    
    @IBAction func addSpentDatetime(sender: AnyObject) {
        
    }
    
    @IBAction func submitNewSpent(sender: AnyObject) {
//        let testObject = PFObject(className: "TestObject")
        let imageee = UIImage(named: "bookAvatarDefault")
        let imageData = UIImagePNGRepresentation(imageee!)
        let imageFile = PFFile(name:"bookAvatarDefault.png", data:imageData!)
        
        let userPhoto = PFObject(className:"TestObject")
        userPhoto["name"] = "Chairman Guo"
        userPhoto["image"] = imageFile
        userPhoto.saveInBackground()
        
//        testObject["foo"] = "bar"
        userPhoto.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
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
            let popoverViewController = segue.destinationViewController
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
            
        }
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
}
