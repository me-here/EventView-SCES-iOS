//
//  ViewController.swift
//  EventView
//
//  Created by Mihir Thanekar on 1/20/21.
//  Copyright © 2021 Mihir Thanekar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    // The main purple button you press to login or register.
    @IBOutlet var mainActionButton: UIButton!
    var authMode: AuthMode = .signIn
    
    // Switches between login and register modes.
    @IBAction func switchModeButtonTapped(_ sender: UIButton) {
        authMode = authMode.other
        sender.setTitle(authMode.other.name, for: .normal)
        mainActionButton.setTitle(authMode.name, for: .normal)
    }
    
    // Validate authentication attempt.
    @IBAction func authenticateButtonTapped(_ sender: UIButton) {
        let user = User(username: "mihi", password: "banana")
        authMode.authentication.authenticate(user: user, handle: { result in
            switch result {
            case .success:
                self.performSegue(withIdentifier: "authenticationSegue", sender: self)
            case .failure(let error):
                self.showError(message: error.rawValue)
            }
        })
    }
}

