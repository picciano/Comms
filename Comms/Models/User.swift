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
    var anonymous: Bool
    var fccInformation: FCCInformation?
    
    static func restoreCurrentUser() {
        if let callsign = UserDefaults.standard.string(forKey: COMMS_CURRENT_USER_KEY) {
            User.currentUser = User(withCallsign: callsign)
            User.currentUser?.loadFCCInformation()
        }
    }
    
    @discardableResult static func signInAnonymously(withCallsign callsign: String? = nil) -> User {
        let user = User(withCallsign: callsign ?? Callsign.anonymous)
        User.currentUser = user
        return user
    }
    
    static func signIn(withFCCInformation fccInformation: FCCInformation, completion: ((User) -> ())) {
        let user = User(withFCCInformation: fccInformation)
        User.currentUser = user
        completion(user)
    }
    
    static func signOut() {
        User.currentUser = nil
    }
    
    private init(withCallsign callsign: String) {
        self.callsign = callsign
        self.anonymous = true
    }
    
    private init(withFCCInformation fccInformation: FCCInformation) {
        self.callsign = fccInformation.current.callsign
        self.fccInformation = fccInformation
        self.anonymous = false
    }
    
    private func loadFCCInformation(completion: (() -> ())? = nil) {
        FCCInformation.from(callsign: callsign) { fccInformation in
            self.fccInformation = fccInformation
            self.anonymous = fccInformation != nil
            completion?()
        }
    }
    
}
