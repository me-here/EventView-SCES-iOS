//
//  User.swift
//  EventView
//
//  Created by Mihir Thanekar on 1/20/21.
//  Copyright © 2021 Mihir Thanekar. All rights reserved.
//

import Foundation

struct User: Codable {
    let username: String
    let password: String
    
    func encode() -> [String: String] {
        return [
            "username": self.username,
            "password": self.password
        ]
    }
}
