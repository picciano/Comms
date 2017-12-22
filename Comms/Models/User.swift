//
//  User.swift
//  Comms
//
//  Created by Anthony Picciano on 12/22/17.
//  Copyright © 2017 Anthony Picciano. All rights reserved.
//

import Foundation

let CommsUserDidChangeNotification = Notification.Name(rawValue: "CommsUserDidChangeNotification")

private let COMMS_CURRENT_USER_KEY = "COMMS_CURRENT_USER"

class User {
    
    static var currentUser: User? {
        didSet {
            UserDefaults.standard.set(currentUser?.callsign, forKey: COMMS_CURRENT_USER_KEY)
            NotificationCenter.default.post(name: CommsUserDidChangeNotification, object: self)
            
            if let user = User.currentUser  {
                log.info("Signed in as \(user.callsign)")
            } else {
                log.info("Not signed in.")
            }
        }
    }
    
    let callsign: String
    var fccInformation: FCCInformation?
    
    static func restoreCurrentUser() {
        if let callsign = UserDefaults.standard.string(forKey: COMMS_CURRENT_USER_KEY) {
            User.currentUser = User(withCallsign: callsign)
            User.currentUser?.loadFCCInformation()
        }
    }
    
    static func signIn(withCallsign callsign: String, completion: @escaping ((User) -> ())) {
        let user = User(withCallsign: callsign)
        User.currentUser = user
        
        user.loadFCCInformation {
            completion(user)
        }
    }
    
    static func signIn(withFCCInformation fccInformation: FCCInformation, completion: ((User) -> ())) {
        let user = User(withFCCInformation: fccInformation)
        User.currentUser = user
        completion(user)
    }
    
    static func logout() {
        User.currentUser = nil
    }
    
    private init(withCallsign callsign: String) {
        self.callsign = callsign
    }
    
    private init(withFCCInformation fccInformation: FCCInformation) {
        self.callsign = fccInformation.current.callsign
        self.fccInformation = fccInformation
    }
    
    private func loadFCCInformation(completion: (() -> ())? = nil) {
        FCCInformation.from(callsign: callsign) { fccInformation in
            self.fccInformation = fccInformation
            completion?()
        }
    }
    
}
