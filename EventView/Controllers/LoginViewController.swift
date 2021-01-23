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
    
}

