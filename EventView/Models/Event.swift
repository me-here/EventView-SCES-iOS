//
//  Event.swift
//  EventView
//
//  Created by Mihir Thanekar on 1/20/21.
//  Copyright © 2021 Mihir Thanekar. All rights reserved.
//

import Foundation

struct Event: Codable {
    /// Unique event identifier
    let id: Int
    
    let name: String
    
    /// Start Date in YYYY-MM-DD hh:mm:ss format
    let start: String
    
    /// End Date in YYYY-MM-DD hh:mm:ss format
    let end: String
    
    let location: String
    
    /// Number of people attending event, can get and set
    var attending: Int
}
