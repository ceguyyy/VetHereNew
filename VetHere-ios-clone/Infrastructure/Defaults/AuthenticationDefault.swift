//
//  AuthenticationDefault.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

protocol AuthenticationDefaults {
    func loadIsVerified() -> Bool
    func saveIsVerified(_ verified: Bool)
}
