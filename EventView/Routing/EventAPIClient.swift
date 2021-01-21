//
//  EventAPIClient.swift
//  EventView
//
//  Created by Mihir Thanekar on 1/20/21.
//  Copyright © 2021 Mihir Thanekar. All rights reserved.
//

import Foundation
import Alamofire

enum EventAPIError: String, Error {
    case networkError = "Due to a network error, we were unable to fulfill your request."
    case eventNotFound = "The selected event was not found in our database. We are sorry."
}

enum AuthError: String, Error {
    case loginFailure = "Sorry, your credentials were invalid or non-existent. Please try again."
    case usernameTaken = "Sorry, that username is already taken. Please take another one."
}

class EventAPIClient {
    static let baseURL: String = "https://jir8pypexa.execute-api.us-west-1.amazonaws.com/api"
    
    static func getEventList(handle: @escaping (Result<[Event], EventAPIError>) -> ()) {
        AF.request(baseURL + "/events").response { response in
            guard response.error == nil else {
                // Error handling
                return
            }
            
            guard let data = response.data else { return }
            do {
                let eventList = try JSONDecoder().decode([Event].self, from: data)
                print(eventList[0].name)
            } catch {
                
            }
            
        }
    }
    
    static func getEventWith(eventID: String) -> Event? {
        return nil
    }
    
    static func setUserIsAttendingEventWith(eventID: String) {
        
    }
}

// MARK: Authentication features
extension EventAPIClient {
    static func attemptLogin(user: User) {
        
    }
    
    static func attemptSignup(user: User) {
        
    }
}
