//
//  AppDelegate.swift
//  Comms
//
//  Created by Anthony Picciano on 12/22/17.
//  Copyright © 2017 Anthony Picciano. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        initializeLogging()
        initializeFirebase()
        initializeUser()
        return true
    }
}
