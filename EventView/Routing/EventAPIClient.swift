//
//  EventAPIClient.swift
//  EventView
//
//  Created by Mihir Thanekar on 1/20/21.
//  Copyright © 2021 Mihir Thanekar. All rights reserved.
//

import Foundation
import Alamofire

/// Things that could go wrong when working with the EventAPI.
enum EventAPIError: String, Error {
    case networkError = "Due to a network error, we were unable to fulfill your request."
    case eventNotFound = "The selected event was not found in our database. We are sorry."
}

// MARK: Event features
class EventAPIClient {
    /// GETs List of Events, with Success (200) & Failure case (not 200).
    func getEventList(handle: @escaping (Result<[Event], EventAPIError>) -> ()) {
        AF.request("\(SharedRouting.baseURL)/events").response { response in
            guard let data = response.data, response.error == nil else {
                handle(.failure(.networkError))
                return
            }
            
            do {
                let eventList = try JSONDecoder().decode([Event].self, from: data)
                handle(.success(eventList))
            } catch {
                handle(.failure(.networkError))
            }
        }
    }
    
    /// GETs single Event with eventID. 200 is success, 404 is not found, anything else is network error.
    func getEventWith(eventID: String, handle: @escaping (Result<Event, EventAPIError>)->()) {
        AF.request("\(SharedRouting.baseURL)/events/\(eventID)").response { response in
            // Handle error cases
            guard let data = response.data, response.error == nil else {
                let code = response.error?.responseCode ?? 400
                switch code {
                case 404:
                    handle(.failure(.eventNotFound))
                default:
                    handle(.failure(.networkError))
                }
                return
            }
            
            do {
                // Got the event.
                let eventList = try JSONDecoder().decode(Event.self, from: data)
                handle(.success(eventList))
            } catch {
                handle(.failure(.networkError))
            }
        }
    }
    
    /// POSTs that the user is attending an eventId. Successful if 200, event not found if 404, else networkError.
    func setUserIsAttendingEventWith(eventID: String, handle: @escaping (Result<(), EventAPIError>)->()) {
        AF.request("\(SharedRouting.baseURL)/events/\(eventID)", method: .post).response { response in
            // Handle error cases
            guard response.error == nil else {
                let code = response.error?.responseCode ?? 400
                switch code {
                case 404:
                    handle(.failure(.eventNotFound))
                default:
                    handle(.failure(.networkError))
                }
                return
            }
            
            handle(.success(()))
        }
    }
}
