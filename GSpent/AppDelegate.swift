//
//  AppDelegate.swift
//  GSpent
//
//  Created by Jiahe Liu on 28/11/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WXApiDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // [Optional] Power your app with Local Datastore. For more info, go to
        // https://parse.com/docs/ios_guide#localdatastore/iOS
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("p0NbZADsyPPGAfV7LgPkHUI6SCkyvjYoQznvqKio",
            clientKey: "DYm2TgUEFZDDCXXUs8EDB5eI5fgrDr2ewkzAeeJ1")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        WXApi.registerApp("wxa50e138039c93c79")
        
        // ...
        
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            handleShortcutItem(shortcutItem)
        }
        return true
    }
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return WXApi.handleOpenURL(url, delegate: self)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return WXApi.handleOpenURL(url, delegate: self)
    }
    
    func onReq(req: BaseReq!) {
        
    }
    
    func onResp(resp: BaseResp!) {
        
    }
    
    func sendText() {
        let req = SendMessageToWXReq()
        req.text = "hahahahahhahahahhahah"
        req.bText = true
        WXApi.sendReq(req)
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        handleShortcutItem(shortcutItem)
    }
    
    private func handleShortcutItem(shortcutItem: UIApplicationShortcutItem) {
        if let rootViewController = window?.rootViewController {
            rootViewController.dismissViewControllerAnimated(false, completion: nil)
            let alertController = UIAlertController(title: "", message: shortcutItem.localizedTitle, preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
//            let newSpentVC = NewSpentViewController()
//            rootViewController.presentViewController(newSpentVC, animated: true, completion: nil)
        }
    }


}

