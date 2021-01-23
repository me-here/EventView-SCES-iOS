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

// MARK: Event features
class EventAPIClient {
    static func getEventList(handle: @escaping (Result<[Event], EventAPIError>) -> ()) {
        AF.request("\(RoutingConstants.baseURL)/events").response { response in
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
    
    static func getEventWith(eventID: String, handle: @escaping (Result<Event, EventAPIError>)->()) {
        AF.request("\(RoutingConstants.baseURL)/events/\(eventID)").response { response in
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
                let eventList = try JSONDecoder().decode(Event.self, from: data)
                handle(.success(eventList))
            } catch {
                handle(.failure(.networkError))
            }
        }
    }
    
    static func setUserIsAttendingEventWith(eventID: String, handle: @escaping (Result<(), EventAPIError>)->()) {
        AF.request("\(RoutingConstants.baseURL)/events/\(eventID)", method: .post).response { response in
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
