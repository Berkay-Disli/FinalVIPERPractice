//
//  AppDelegate.swift
//  FinalVIPERPractice
//
//  Created by Berkay Dişli on 21.11.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let todoListRouter = TodoRouter.startExecution()
        let initialVC = todoListRouter.entry
        
        window?.rootViewController = UINavigationController(rootViewController: initialVC!)
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

