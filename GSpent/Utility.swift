//
//  Utility.swift
//  GSpent
//
//  Created by Jiahe Liu on 12/12/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//

import Foundation
import Parse
import UIKit


protocol RefreshBookTableViewControllerDelegate{
    func refreshBookTableViewController()
    
}

class Utility{
    static var currentUser = PFUser()
    static var hasCurrentUser = false
    static var mDelegate:RefreshBookTableViewControllerDelegate?
    class func getCurrentUser(){
        
        let query = PFQuery(className:"_User")
        
        query.getObjectInBackgroundWithId(UserIDs[myUserID]) {
            (user1: PFObject?, error: NSError?) -> Void in
            if error == nil && user1 != nil {
                Utility.currentUser = user1 as! PFUser
                print(currentUser.objectId)
                hasCurrentUser = true
                self.mDelegate?.refreshBookTableViewController()
            } else {
                print(error)
            }
        }
    }
    
    
    
    
    
    class func getStrMates(raw_s: [String]) -> String {
        var part_s: String!
        if     (raw_s.count == 1) {part_s = "\(raw_s[0])."}
        else if(raw_s.count == 2){part_s = "\(raw_s[0]), \(raw_s[1])."}
        else if(raw_s.count >  2){part_s = "\(raw_s[0]), \(raw_s[1]), and other \(raw_s.count-2) people."}
        else   {part_s = ""}
        return part_s
    }
    
    class func getStrMatesFromObjects(b_parts: [PFObject]) -> String {
        var raw_s = [String]()
        for b_part in b_parts {
            raw_s.append(b_part["username"] as! String)
        }
        var part_s: String!
        if     (raw_s.count == 1) {part_s = "\(raw_s[0])."}
        else if(raw_s.count == 2){part_s = "\(raw_s[0]), \(raw_s[1])."}
        else if(raw_s.count >  2){part_s = "\(raw_s[0]), \(raw_s[1]), and other \(raw_s.count-2) people."}
        else   {part_s = ""}
        return part_s
    }
    
    class func scaleUIImageToSize(let image: UIImage, let size: CGSize) -> UIImage {
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    class func addBorder(view: UIView, border: CGFloat, radius: CGFloat, color: UIColor){
        view.backgroundColor = UIColor.clearColor()
        view.layer.borderWidth = border
        view.layer.cornerRadius = radius
        view.layer.borderColor = color.CGColor
        view.layer.masksToBounds = true
    }
    
    class func addButtonStyle(view: UIButton, border: CGFloat, radius: CGFloat, textColor: UIColor, borderColor: UIColor){
        Utility.addBorder(view, border: border, radius: radius, color: borderColor)
        view.setTitleColor(textColor, forState: UIControlState.Normal)
        view.titleLabel!.font      = UIFont.boldSystemFontOfSize(16.0)
    }
    
    
    class func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.grayColor()
        }
        
        let rString = (cString as NSString).substringToIndex(2)
        let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    
}
