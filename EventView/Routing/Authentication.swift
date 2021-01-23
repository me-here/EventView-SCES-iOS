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

struct CredentialManager {
    private static let protectionSpace = URLProtectionSpace(host: SharedRouting.baseURL, port: 80, protocol: "https", realm: "Restricted", authenticationMethod: NSURLAuthenticationMethodHTTPBasic)
    
    /// Caches the credentials from a given User object into URLCredentialStorage, if it is not already in URLCredentialStorage.
    func saveCredentials(user: User) {
        let credential = URLCredential(user: user.username, password: user.password, persistence: .permanent)
        guard let storedCred = URLCredentialStorage.shared.credentials(for: CredentialManager.protectionSpace)?[user.username], storedCred.user != credential.user, storedCred.password != credential.password else {
            return
        }
        URLCredentialStorage.shared.set(credential, for: CredentialManager.protectionSpace)
    }
    
    func getUserFromCachedCredentials() -> User? {
        guard let credential = URLCredentialStorage.shared.defaultCredential(for: CredentialManager.protectionSpace) else { return nil }
        guard let username = credential.user else { return nil }
        guard let password = credential.password else { return nil }
        return User(username: username, password: password)
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
