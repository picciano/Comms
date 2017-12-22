//
//  SignInViewController.swift
//  Comms
//
//  Created by Anthony Picciano on 12/22/17.
//  Copyright © 2017 Anthony Picciano. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var callsignTextField: UITextField!
    @IBOutlet weak var typeOrClassLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLine1Label: UILabel!
    @IBOutlet weak var addressLine2Label: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    
    var fccInformation: FCCInformation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateDisplay()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        callsignTextField.becomeFirstResponder()
    }
    
    private func updateDisplay(isSearch: Bool = false) {
        nameLabel.text = fccInformation?.name
        typeOrClassLabel.text = typeOrClass
        addressLine1Label.text = fccInformation?.address.line1
        addressLine2Label.text = fccInformation?.address.line2
        
        if isSearch && fccInformation == nil {
            nameLabel.text = "Callsign was not found."
        }
        
        signInButton.isHidden = fccInformation == nil
    }
    
    private var typeOrClass: String? {
        if fccInformation?.type == .person {
            return fccInformation?.current.operClass.rawValue
        }
        
        return fccInformation?.type.rawValue
    }
    
    @IBAction func searchAction(_ sender: Any) {
        if let callsign = callsignTextField.text {
            FCCInformation.from(callsign: callsign) { fccInformation in
                self.fccInformation = fccInformation
                self.updateDisplay(isSearch: true)
            }
        }
    }
    
    @IBAction func clearAction(_ sender: Any) {
        fccInformation = nil
        callsignTextField.text = nil
        callsignTextField.becomeFirstResponder()
        updateDisplay()
    }
    
    @IBAction func signInAction(_ sender: Any) {
        guard let fccInformation = fccInformation else {
            return
        }
        
        let viewController = UIAlertController(title: "Sign In", message: "By signing in, I certify and acknowlegdge that I am the owner or trustee of the callsign \(fccInformation.current.callsign).", preferredStyle: .alert)
        viewController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        viewController.addAction(UIAlertAction(title: "I Agree", style: .default) { action in
            User.signIn(withFCCInformation: fccInformation) { user in
                self.performSegue(withIdentifier: "UnwindToHome", sender: self)
            }
        })
        present(viewController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchAction(textField)
        textField.resignFirstResponder()
        return true
    }
    
}
