//
//  LandingView.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import SwiftUI

struct SplashView: View {
    @StateObject private var viewModel: SplashViewModel

    init(_ coordinator: any AppCoordinatorProtocol) {
        self._viewModel = StateObject(
            wrappedValue: SplashViewModel(coordinator)
        )
    }

    var body: some View {
        Text("SplashScreen")
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    viewModel.onInput(.DidAnimationFinished)
                }
            }
    }
}

#Preview {
    @Previewable
    @StateObject var appCoordinator = AppCoordinator()
    NavigationStack(path: $appCoordinator.path){
        SplashView(appCoordinator)
            .navigationDestination(for: Screen.self) { screen in
                appCoordinator.build(screen)
            }
    }
}
