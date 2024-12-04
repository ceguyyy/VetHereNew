//
//  VetHere_ios_cloneApp.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import SwiftUI

@main
struct VetHere_ios_cloneApp: App {
    @StateObject private var appCoordinator = AppCoordinator()
    @AppStorage(AuthenticationUserDefaults.Constant.verifiedKey) private var isVerified: Bool = false

    init(){
        AppDI.Inject()
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appCoordinator.path){
                appCoordinator.build(.splash)
                    .navigationDestination(for: Screen.self) { screen in
                        appCoordinator.build(screen)
                    }
            }
        }
        .onChange(of: isVerified) {
            if !isVerified {
                appCoordinator.popToRoot()
                appCoordinator.push(.login)
            }
        }
    }
}
