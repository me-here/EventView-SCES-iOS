//
//  ViewController.swift
//  EventView
//
//  Created by Mihir Thanekar on 1/20/21.
//  Copyright © 2021 Mihir Thanekar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        EventAPIClient.getEventList(handle: { result in
            switch result {
            case .success(let eventList):
                print(eventList[0])
            case .failure(let error):
                print(error.rawValue)
            }
        })
        
    }


}

