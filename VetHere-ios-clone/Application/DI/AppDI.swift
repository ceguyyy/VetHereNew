//
//  AppDI.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

struct AppDI{
    static func Inject(){
        // network manager
        @Provider var networkManager:NetworkManager = NetworkManager.shared
    }
}
