//
//  AppCoordinatorProtocol.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import SwiftUI

protocol AppCoordinatorProtocol: ObservableObject {
    var path: NavigationPath { get set }
    var currentTab: ApplicationTab { get set }

    func push(_ screen:  Screen)
    func pop()
    func pop(_ count: Int)
    func popToRoot()
    func dismissSheet()
    func dismissFullScreenOver()
}
