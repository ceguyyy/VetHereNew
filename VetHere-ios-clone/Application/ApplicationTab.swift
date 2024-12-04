//
//  ApplicationTab.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import SwiftUI

enum ApplicationTab: Identifiable, CaseIterable {
    case Clinic
    case History
    case myPet
    
    var id: Self { return self }
}
