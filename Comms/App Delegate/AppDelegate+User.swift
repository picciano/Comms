//
//  AppDelegate+User.swift
//  Comms
//
//  Created by Anthony Picciano on 12/22/17.
//  Copyright © 2017 Anthony Picciano. All rights reserved.
//

import Foundation

extension AppDelegate {
    
    func initializeUser() {
        User.restoreCurrentUser()
    }
}
