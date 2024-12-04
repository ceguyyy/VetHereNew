//
//  Screen.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

enum Screen: Identifiable, Hashable{
    case splash
    case login
    case nearestVet
    case register
//    case contentView
    var id: Self { return self }
}
