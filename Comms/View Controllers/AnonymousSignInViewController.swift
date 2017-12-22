//
//  AnonymousSignInViewController.swift
//  Comms
//
//  Created by Anthony Picciano on 12/22/17.
//  Copyright © 2017 Anthony Picciano. All rights reserved.
//

import UIKit

class AnonymousSignInViewController: UIViewController {

    @IBOutlet weak var callsignLabel: UILabel!
    @IBOutlet weak var phoeneticsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDisplay()
    }
    
    func updateDisplay() {
        let callsign = Callsign.anonymous
        callsignLabel.text = callsign
        phoeneticsLabel.text = callsign.phonetically()
    }
    
    @IBAction func regenerateAction(_ sender: Any) {
        updateDisplay()
    }
    
    @IBAction func signInAnonymouslyAction(_ sender: Any) {
        if let callsign = callsignLabel.text {
            User.signInAnonymously(withCallsign: callsign)
            performSegue(withIdentifier: "UnwindToHome", sender: self)
        }
    }
}
