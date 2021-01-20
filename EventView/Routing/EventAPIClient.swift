//
//  EventAPIClient.swift
//  EventView
//
//  Created by Mihir Thanekar on 1/20/21.
//  Copyright © 2021 Mihir Thanekar. All rights reserved.
//

import Foundation
import Alamofire

class EventAPIClient {
    static let baseURL: String = "https://jir8pypexa.execute-api.us-west-1.amazonaws.com/api"
    
    static func getEventList() {
        AF.request(baseURL + "/events").response { response in
            print(response)
        }
    }
    
    static func getEventWith(eventID: String) -> Event? {
        return nil
    }
    
    static func setUserIsAttendingEventWith(eventID: String) {
        
    }
    
    static func attemptLogin(user: User) {
        
    }
    
    static func attemptSignup(user: User) {
        
    }
}
