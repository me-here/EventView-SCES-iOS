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
    case networkError = "Due to a network error, we were unable to fulfill your request."
}

// MARK: Authentication Protocol treats all authentication objects the same way.
protocol Authentication {
    func authenticate(user: User, handle: @escaping (Result<(), AuthError>)->())
}

// The Login case.
struct Login: Authentication {
    func authenticate(user: User, handle: @escaping (Result<(), AuthError>) -> ()) {
        AF.request("\(SharedRouting.baseURL)/login",
            method: .post,
            parameters: user.encode(),
            encoder: JSONParameterEncoder.default
        ).response { response in
            guard response.response?.statusCode == 200 else {
                switch response.response?.statusCode {
                case 401:
                    handle(.failure(.loginFailure))
                default:
                    handle(.failure(.networkError))
                }
                return
            }
            handle(.success(()))
        }
    }
}

// The Authentication case.
struct Register: Authentication {
    func authenticate(user: User, handle: @escaping (Result<(), AuthError>) -> ()) {
        AF.request("\(SharedRouting.baseURL)/signup",
            method: .post,
            parameters: user.encode(),
            encoder: JSONParameterEncoder.default
        ).response { response in
            guard response.response?.statusCode == 200 else {
                switch response.response?.statusCode {
                case 400:
                    handle(.failure(.usernameTaken))
                default:
                    handle(.failure(.networkError))
                }
                return
            }
            handle(.success(()))
        }
    }
}

// MARK: User facing view of states in auth.

enum AuthMode {
    case signIn
    case register
    
    var name: String {
        switch self {
        case .register:
            return "Register"
        case .signIn:
            return "Login"
        }
    }
    
    var authentication: Authentication {
        switch self {
        case .register:
            return Register()
        case .signIn:
            return Login()
        }
    }
    
    var other: AuthMode {
        return self == .signIn ? .register : .signIn
    }
}
