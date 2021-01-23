//
//  ViewController.swift
//  EventView
//
//  Created by Mihir Thanekar on 1/20/21.
//  Copyright © 2021 Mihir Thanekar. All rights reserved.
//
//  Main image on this screen is free for public, personal, and commercial use.

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    // The main purple button you press to login or register.
    @IBOutlet var mainActionButton: UIButton!
    var authMode: AuthMode = .signIn
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.delegate = self
        passwordField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: moving keyboard up and down
    
    @objc func keyboardWillShow(notification: Notification) {
        guard view.frame.origin.y == 0 else { return }  // only move up if keyboard is at bottom
        guard let keyboardRect = notification.userInfo?["UIKeyboardBoundsUserInfoKey"] as? CGRect else { return }
        view.frame.origin.y -= keyboardRect.height
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        guard view.frame.origin.y != 0 else { return }  // already at bottom? don't move down.
        view.frame.origin.y = 0
    }
    
    // Switches between login and register modes.
    @IBAction func switchModeButtonTapped(_ sender: UIButton) {
        authMode = authMode.other
        sender.setTitle(authMode.other.name, for: .normal)
        mainActionButton.setTitle(authMode.name, for: .normal)
    }
    
    // Validate authentication attempt.
    @IBAction func authenticateButtonTapped(_ sender: UIButton) {
        guard let username = usernameField.text else {return}
        guard let password = passwordField.text else {return}
        let user = User(username: username, password: password)
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

extension LoginViewController: UITextFieldDelegate {
    // Pressing return dismisses the keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

