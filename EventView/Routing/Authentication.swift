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

// MARK: Authentication Protocol allows you to call all authentication objects the same way.
protocol Authentication {
    func authenticate(user: User, handle: @escaping (Result<(), AuthError>)->())
}

// The Login case.
struct Login: Authentication {
    func authenticate(user: User, handle: @escaping (Result<(), AuthError>) -> ()) {
        AF.request("\(RoutingConstants.baseURL)/login", method: .post, parameters: user.encode()).response { response in
            guard response.error == nil else {  // Not 200 --> .loginFailure
                handle(.failure(.loginFailure))
                return
            }
        }
    }
}

// The Authentication case.
struct Register: Authentication {
    func authenticate(user: User, handle: @escaping (Result<(), AuthError>) -> ()) {
        AF.request("\(RoutingConstants.baseURL)/signup", method: .post, parameters: user.encode()).response { response in
            guard response.error == nil else {
                handle(.failure(.usernameTaken))
                return
            }
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
            return Login()
        case .signIn:
            return Login()
        }
    }
    
    var other: AuthMode {
        return self == .signIn ? .register : .signIn
    }
}
