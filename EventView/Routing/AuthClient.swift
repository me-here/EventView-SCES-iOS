//
//  AuthClient.swift
//  EventView
//
//  Created by Mihir Thanekar on 1/22/21.
//  Copyright © 2021 Mihir Thanekar. All rights reserved.
//

import Foundation
import Alamofire

enum AuthError: String, Error {
    case loginFailure = "Sorry, your credentials were invalid or non-existent. Please try again."
    case usernameTaken = "Sorry, that username is already taken. Please take another one."
}

class AuthClient {
    func attemptLogin(user: User, handle: @escaping (Result<(), AuthError>)->()) {
        AF.request("\(RoutingConstants.baseURL)/login", method: .post, parameters: user.encode()).response { response in
            guard response.error == nil else {  // Not 200 --> .loginFailure
                handle(.failure(.loginFailure))
                return
            }
        }
    }
    
    func attemptSignup(user: User, handle: @escaping (Result<(), AuthError>)->()) {
        AF.request("\(RoutingConstants.baseURL)/signup", method: .post, parameters: user.encode()).response { response in
            guard response.error == nil else {
                handle(.failure(.usernameTaken))
                return
            }
        }
    }
}
