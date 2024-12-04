//
//  AuthenticationDefault.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

final class AuthenticationUserDefaults: AuthenticationDefaults {
    private let defaults = UserDefaults.standard
    
    static let shared = AuthenticationUserDefaults()
    
    private init() {  }
    
    func loadIsVerified() -> Bool {
        return defaults
            .value(forKey: Constant.verifiedKey) as? Bool
        ?? false
    }
    
    func saveIsVerified(_ verified: Bool) {
        defaults
            .setValue(
                verified,
                forKey: Constant.verifiedKey
            )
    }
    
    struct Constant {
        static let verifiedKey: String = "Verified"
    }
}
