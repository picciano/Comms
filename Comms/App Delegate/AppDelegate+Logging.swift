//
//  AppDelegate+Logging.swift
//  Comms
//
//  Created by Anthony Picciano on 12/22/17.
//  Copyright © 2017 Anthony Picciano. All rights reserved.
//

import Foundation
import SwiftyBeaver

let log = SwiftyBeaver.self

extension AppDelegate {
    
    func initializeLogging() {
        let console = ConsoleDestination()
        console.minLevel = .debug
        
        log.removeAllDestinations()
        log.addDestination(console)
    }
    
}
