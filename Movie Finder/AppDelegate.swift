//
//  AppDelegate.swift
//  Movie Finder
//
//  Created by Esraa Gamal on 10/18/20.
//  Copyright © 2020 Esraa Gamal. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    //    @IBOutlet weak var titleLabel : UILabel!
    //    @IBOutlet weak var imageView : UIImageView!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //         Override point for customization after application launch.
        //        let title = "MOVIE FINDER"
        //        imageView.alpha = 0
        //               var counter = 0.0
        //               for char in title {
        //                   Timer.scheduledTimer(withTimeInterval: 0.1 * counter, repeats: false) { (Timer) in
        //
        //                       self.titleLabel?.text?.append(char)
        //                   }
        //                counter += 1
        //               }
        //
        //        UIView.animate(withDuration: 1, animations: {
        //                   self.imageView.alpha = 1
        //               })
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

