//
//  Event.swift
//  EventView
//
//  Created by Mihir Thanekar on 1/20/21.
//  Copyright © 2021 Mihir Thanekar. All rights reserved.
//

import Foundation

class Event: Codable {
    // Unique event identifier
    let id: Int
    
    let name: String
    
    // Dates in YYYY-MM-DD hh:mm:ss format
    let start: String
    let end: String
    
    let location: String
    
    // Number of people attending event
    let attending: Int
}
