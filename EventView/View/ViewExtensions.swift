//
//  ViewExtensions.swift
//  EventView
//
//  Created by Mihir Thanekar on 1/22/21.
//  Copyright © 2021 Mihir Thanekar. All rights reserved.
//

import UIKit

extension UIViewController {
    func showError(title: String = "Error", message: String = "Something went wrong!") {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(.init(title: "Dismiss", style: .default, handler: nil))
        present(alertVC, animated: true)
    }
}
