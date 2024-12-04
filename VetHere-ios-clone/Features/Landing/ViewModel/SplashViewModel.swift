//
//  SplashViewModel.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

class SplashViewModel : ObservableObject{
    private let coordinator: any AppCoordinatorProtocol
    private let authenticationDefault = AuthenticationUserDefaults.shared
    init(_ coordinator: any AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    enum Input {
        case DidAnimationFinished
    }
    
    
    func onInput(_ input: Input) {
        switch input {
        case .DidAnimationFinished:
            print("animation finished")
            let isVerified = authenticationDefault.loadIsVerified()
            if isVerified {
                coordinator.push(.contentView)
                return
            }
            coordinator.push(.login)
        }
    }
}
