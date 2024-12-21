//
//  KeyChainManager.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

public class KeychainCredentialManager {
    public static let shared = KeychainCredentialManager()
    private let keyChain = KeychainSwift.shared
    private let authenticationDefaults = AuthenticationUserDefaults.shared
    
    private init () {  }
    
    
    
    func fetchCredential() -> Token? {
        guard let accessToken = keyChain.get(Constant.credentialKey),
              let refreshToken = keyChain.get(Constant.refreshKey)
        else {
            return nil
        }
        
        return Token(
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }
    
    func setCredential(
        withToken token: String,
        withRefreshToken refreshToken: String
    ) {
        keyChain.set(
            token,
            forKey: Constant.credentialKey
        )
        
        keyChain.set(
            refreshToken,
            forKey: Constant.refreshKey
        )
    }
    
    func clearCredentials() {
        authenticationDefaults.saveIsVerified(false)
           print("Credentials cleared from Keychain")
       }
    
    
    struct Constant {
        static let credentialKey = "Token"
        static let refreshKey = "Refresh"
    }
}

struct Token {
    let accessToken: String
    let refreshToken: String
}
