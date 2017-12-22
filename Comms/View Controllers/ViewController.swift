//
//  ViewController.swift
//  Comms
//
//  Created by Anthony Picciano on 12/22/17.
//  Copyright © 2017 Anthony Picciano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var signInBarButtonItem: UIBarButtonItem!
    @IBOutlet var signOutBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(userDidChangeHandler(notification:)), name: CommsUserDidChangeNotification, object: nil)
        updateDisplay()
    }

    func updateDisplay() {
        if let user = User.currentUser {
            statusLabel.text = "You are signed in as \(user.callsign)."
            navigationItem.rightBarButtonItem = signOutBarButtonItem
        } else {
            statusLabel.text = "You are not signed in."
            navigationItem.rightBarButtonItem = signInBarButtonItem
        }
        
        // fix for iOS 11.2
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    @objc func userDidChangeHandler(notification: Notification) {
        updateDisplay()
    }
    
    @IBAction func signOutAction(_ sender: Any) {
        let viewController = UIAlertController(title: "Confirm", message: "Do you want to sign out?", preferredStyle: .alert)
        viewController.addAction(UIAlertAction(title: "Keep me signed in", style: .cancel))
        viewController.addAction(UIAlertAction(title: "Sign me out", style: .destructive, handler: { action in
            User.signOut()
        }))
        present(viewController, animated: true)
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        //nothing goes here
    }
}

