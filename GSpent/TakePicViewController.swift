//
//  TakePicViewController.swift
//  GSpent
//
//  Created by Jiahe Liu on 8/12/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//

import UIKit
import MobileCoreServices

protocol sendPictureBack
{
    func sendpictureToPreviousVC(spentPic: UIImage)
}

class TakePicViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var mDelegate: sendPictureBack?
    
    @IBOutlet weak var imageView: UIImageView!
    var spentImage: UIImage?
    var newMedia: Bool?
    @IBOutlet weak var takePhotoBtn: UIButton!
    @IBOutlet weak var selectPhotoInRollBtn: UIButton!
    // 初始化图片选择控制器
    let imagePickerController: UIImagePickerController = UIImagePickerController()
    var isFullScreen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utility.addButtonStyle(takePhotoBtn, border: 2, radius: 5, textColor: Utility.colorWithHexString(colorPrimary[4]), borderColor: Utility.colorWithHexString(colorPrimary[4]))
        Utility.addButtonStyle(selectPhotoInRollBtn, border: 2, radius: 5, textColor: Utility.colorWithHexString(colorPrimary[4]), borderColor: Utility.colorWithHexString(colorPrimary[4]))
        Utility.addBorder(imageView, border: 2, radius: 5, color: Utility.colorWithHexString(colorPrimary[4]))
        
        // Do any additional setup after loading the view, typically from a nib.
        //self.imageView.frame = CGRect(x: 264, y: 630, width: 50, height: 50)//CGRectMake(100, 100, 128, 128)
        imageView.image = spentImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func useCamera(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.Camera) {
                
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.sourceType =
                    UIImagePickerControllerSourceType.Camera
                imagePicker.mediaTypes = [kUTTypeImage as NSString as String]
                imagePicker.allowsEditing = false
                
                self.presentViewController(imagePicker, animated: true, 
                    completion: nil)
                newMedia = true
        }
    }
    @IBAction func useCameraRoll(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.SavedPhotosAlbum) {
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.sourceType =
                    UIImagePickerControllerSourceType.PhotoLibrary
                imagePicker.mediaTypes = [kUTTypeImage as NSString as String]
                imagePicker.allowsEditing = false
                self.presentViewController(imagePicker, animated: true,
                    completion: nil)
                newMedia = false
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
     
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if mediaType == (kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            
            imageView.image = image
            
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                    "image:didFinishSavingWithError:contextInfo:", nil)
            } else if mediaType==(kUTTypeMovie as String) {
                // Code to support video here
            }
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafePointer<Void>) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                message: "Failed to save image",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true,
                completion: nil)
        }
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func determinePhoto(sender: AnyObject) {
        if(imageView.image != nil){
            self.mDelegate?.sendpictureToPreviousVC(imageView.image!)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
//    
//    
//    @IBAction func chooseImage(sender: UIButton) {
//        // 设置代理
//        self.imagePickerController.delegate = self
//        // 设置是否可以管理已经存在的图片或者视频
//        self.imagePickerController.allowsEditing = true
//        
//        // 判断是否支持相机
//        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
//            let alertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
//            //在iPad上使用表单（ActionSheet）需要设置描点(anchor point)
//            let popover = alertController.popoverPresentationController
//            if (popover != nil){
//                popover?.sourceView = sender
//                popover?.sourceRect = sender.bounds
//                popover?.permittedArrowDirections = UIPopoverArrowDirection.Any
//            }
//            
//            let cameraAction: UIAlertAction = UIAlertAction(title: "拍照换头像", style: .Default) { (action: UIAlertAction!) -> Void in
//                // 设置类型
//                self.imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
//                self.presentViewController(self.imagePickerController, animated: true, completion: nil)
//            }
//            alertController.addAction(cameraAction)
//            
//            let photoLibraryAction: UIAlertAction = UIAlertAction(title: "从相册选择换头像", style: .Default) { (action: UIAlertAction!) -> Void in
//                // 设置类型
//                self.imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//                //改navigationBar背景色
//                self.imagePickerController.navigationBar.barTintColor = UIColor(red: 171/255, green: 202/255, blue: 41/255, alpha: 1.0)
//                //改navigationBar标题色
//                self.imagePickerController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
//                //改navigationBar的button字体色
//                self.imagePickerController.navigationBar.tintColor = UIColor.whiteColor()
//                self.presentViewController(self.imagePickerController, animated: true, completion: nil)
//            }
//            alertController.addAction(photoLibraryAction)
//            
//            let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
//            alertController.addAction(cancelAction)
//
//            presentViewController(alertController, animated: true, completion: nil)
//            
//        }else{
//            let alertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
//            //设置描点(anchor point)
//            let popover = alertController.popoverPresentationController
//            if (popover != nil){
//                popover?.sourceView = sender
//                popover?.sourceRect = sender.bounds
//                popover?.permittedArrowDirections = UIPopoverArrowDirection.Any
//            }
//            
//            let photoLibraryAction: UIAlertAction = UIAlertAction(title: "从相册选择换头像", style: .Default) { (action: UIAlertAction!) -> Void in
//                // 设置类型
//                self.imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//                //改navigationBar背景色
//                self.imagePickerController.navigationBar.barTintColor = UIColor(red: 171/255, green: 202/255, blue: 41/255, alpha: 1.0)
//                //改navigationBar标题色
//                self.imagePickerController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
//                //改navigationBar的button字体色
//                self.imagePickerController.navigationBar.tintColor = UIColor.whiteColor()
//                self.presentViewController(self.imagePickerController, animated: true, completion: nil)
//            }
//            alertController.addAction(photoLibraryAction)
//            
//            let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
//            alertController.addAction(cancelAction)
//            
//            presentViewController(alertController, animated: true, completion: nil)
//        }
//    }
//    
//    //实现ImagePicker delegate 事件
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        picker.dismissViewControllerAnimated(true, completion: nil)
//        var image: UIImage!
//        // 判断，图片是否允许修改
//        if(picker.allowsEditing){
//            //裁剪后图片
//            image = info[UIImagePickerControllerEditedImage] as! UIImage
//        }else{
//            //原始图片
//            image = info[UIImagePickerControllerOriginalImage] as! UIImage
//        }
//        /* 此处info 有六个值
//        * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
//        * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
//        * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
//        * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
//        * UIImagePickerControllerMediaURL;       // an NSURL
//        * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
//        * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
//        */
//        // 保存图片至本地，方法见下文
//        self.saveImage(image, newSize: CGSize(width: 256, height: 256), percent: 0.5, imageName: "currentImage.png")
//        
//        let fullPath  = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent("Documents").URLByAppendingPathComponent("currentImage.png")
//        
//        let savedImage: UIImage = UIImage(contentsOfFile: fullPath as NSString)!
//        self.isFullScreen = false
//        self.imageView.image = savedImage
//        //在这里调用网络通讯方法，上传头像至服务器...
//    }
//    // 当用户取消时，调用该方法
//    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    //保存图片至沙盒
//    func saveImage(currentImage: UIImage, newSize: CGSize, percent: CGFloat, imageName: String){
//        //压缩图片尺寸
//        UIGraphicsBeginImageContext(newSize)
//        currentImage.drawInRect(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
//        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        //高保真压缩图片质量
//        //UIImageJPEGRepresentation此方法可将图片压缩，但是图片质量基本不变，第二个参数即图片质量参数。
//        let imageData: NSData = UIImageJPEGRepresentation(newImage, percent)!
//        // 获取沙盒目录,这里将图片放在沙盒的documents文件夹中
//        let fullPath  = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent("Documents").URLByAppendingPathComponent(imageName)
//        // 将图片写入文件
//        imageData.writeToURL(fullPath, atomically: false)
//    }
//    
//    //实现点击图片预览功能，滑动放大缩小，带动画
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.isFullScreen = !self.isFullScreen
//        
//        let touch: UITouch = touches.first! as UITouch
//        let touchPoint: CGPoint  = touch.locationInView(self.view)
//        let imagePoint: CGPoint = self.imageView.frame.origin
//        //touchPoint.x ，touchPoint.y 就是触点的坐标
//        // 触点在imageView内，点击imageView时 放大,再次点击时缩小
//        if(imagePoint.x <= touchPoint.x && imagePoint.x + self.imageView.frame.size.width >= touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+self.imageView.frame.size.height >= touchPoint.y){
//            // 设置图片放大动画
//            UIView.beginAnimations(nil, context: nil)
//            // 动画时间
//            UIView.setAnimationDuration(1)
//            
//            if (isFullScreen) {
//                // 放大尺寸
//                self.imageView.frame = CGRectMake(0, 0, 480, 320)
//            }
//            else {
//                // 缩小尺寸
//                self.imageView.frame = CGRectMake(100, 100, 128, 128)
//            }
//            // commit动画
//            UIView.commitAnimations()
//        }
//    }
}