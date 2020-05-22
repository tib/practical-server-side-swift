//
//  AppDelegate.swift
//  MyProject
//
//  Created by Tibor Bodecs on 2020. 05. 15..
//  Copyright © 2020. Tibor Bodecs. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    var accountView: AccountView?
}

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        application.registerForRemoteNotifications()
   
        return true
    }
    
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return .init(name: "Default Configuration",
                     sessionRole: connectingSceneSession.role)
    }
    //...
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print(token)
        UserDefaults.standard.set(token, forKey: "device-token")
        UserDefaults.standard.synchronize()
        self.accountView = App.shared.modules.account() as? AccountView
        self.accountView?.presenter?.registerUserDevice() { [unowned self] in
            self.accountView = nil
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
}

