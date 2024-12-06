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
        ImageView(imageURL: "https://cdn.dribbble.com/userupload/10694930/file/original-40090094f817aa42c4a7eba8c6f1a61f.jpg?resize=400x0", width: 400, height:300 )
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
