//
//  BaseAppDelegate.swift
//  AigensIOSPlayground
//
//  Created by Peter Liu on 6/10/2016.
//  Copyright © 2016 Aigens. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging

public class BaseAppDelegate: UIResponder, UIApplicationDelegate{
    
    public var window: UIWindow?
    
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        // Override point for customization after application launch.
        /*
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self
        */
        
        setupPush(application)
        
        return true
    }
    
    
    func setupPush(_ application: UIApplication){
        
        // [START register_for_notifications]
        if #available(iOS 10.0, *) {
            let authOptions : UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_,_ in })
            
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            // For iOS 10 data message (sent via FCM)
            FIRMessaging.messaging().remoteMessageDelegate = self
            
            debugPrint("ios 10 push registered")
            
        } else {
            
             let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
             application.registerUserNotificationSettings(settings)
             application.registerForRemoteNotifications()
        }
        
        
        // [END register_for_notifications]
        
        FIRApp.configure()
        
        
        // Add observer for InstanceID token refresh callback.
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.tokenRefreshNotification),
                                               name: NSNotification.Name.firInstanceIDTokenRefresh,
                                               object: nil)
        
        
        let token = FIRInstanceID.instanceID().token()
        debugPrint("current push token", token)
        
        debugPrint("calling register for remote push")
        application.registerForRemoteNotifications()
        
    }
    
    
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        debugPrint("apple token", deviceToken)
        
        //FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenTypeSandbox)
        
        
    }
    
    // [START receive_message]
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // Print message ID.
        //debugPrint("Message ID: \(userInfo["gcm.message_id"]!)")
        
        // Print full message.
        debugPrint("C:%@", userInfo)
        
        completionHandler(.newData)
        
        handlePush(data: userInfo)
        
        
    }
    // [END receive_message]
    
    // [START refresh_token]
    func tokenRefreshNotification(_ notification: Notification) {
        if let refreshedToken = FIRInstanceID.instanceID().token() {
            debugPrint("InstanceID token: \(refreshedToken)")
        }
        
        // Connect to FCM since connection may have failed when attempted before having a token.
        connectToFcm()
    }
    // [END refresh_token]
    
    // [START connect_to_fcm]
    func connectToFcm() {
        FIRMessaging.messaging().connect { (error) in
            if (error != nil) {
                debugPrint("Unable to connect with FCM. \(error)")
            } else {
                debugPrint("Connected to FCM.")
                let token = FIRInstanceID.instanceID().token()
                debugPrint("current push token", token)
            }
        }
    }
    // [END connect_to_fcm]
    
    
    public func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    public func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        FIRMessaging.messaging().disconnect()
        debugPrint("Disconnected from FCM.")
    }
    
    public func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        connectToFcm()
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Split view
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        
        /*
         guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
         guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
         if topAsDetailController.detailItem == nil {
         // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
         return true
         }*/
        return false
    }
    
    func handlePush(data: [AnyHashable: Any]){
        
        NotificationCenter.default.post(name: .pushHandler, object: self, userInfo: data)
        debugPrint("posted global notification for push")
    }
    
}




// [START ios_10_message_handling]
@available(iOS 10, *)
extension BaseAppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //let userInfo = notification.request.content.userInfo
        // Print message ID.
        //debugPrint("Message ID: \(userInfo["gcm.message_id"]!)")
        
        // Print full message.
        //debugPrint("A:%@", userInfo)
    }
}

extension BaseAppDelegate : FIRMessagingDelegate {
    // Receive data message on iOS 10 devices.
    public func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) {
        //debugPrint("B:%@", remoteMessage.appData)
    }
}

// [END ios_10_message_handling]
