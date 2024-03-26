//
//  AuthTokenStorage.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 10.01.2024.
//

import Foundation
import SwiftKeychainWrapper

protocol AuthStorageProtocol {
    var userID: Int? { get set }
    var token: String? { get set }
    func removeUserID()
    func removeToken()
}

final class AuthStorage: AuthStorageProtocol {
    private var keyChain = KeychainWrapper.standard
    
    var userID: Int? {
        get {
            keyChain.integer(forKey: "userID")
        }
        
        set {
            guard let newValue = newValue else { return }
            keyChain.set(newValue, forKey: "userID")
        }
    }
    
    var token: String? {
        get {
            keyChain.string(forKey: "bearerToken")
        }
        
        set {
            guard let newValue = newValue else { return }
            keyChain.set(newValue, forKey: "bearerToken")
        }
    }
    
    func removeUserID() {
        keyChain.removeObject(forKey: "userID")
    }
    
    func removeToken() {
        keyChain.removeObject(forKey: "userID")
    }
    
}
