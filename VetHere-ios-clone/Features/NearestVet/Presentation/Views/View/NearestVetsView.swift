//
//  NearestVetsView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 05/12/24.
//

import SwiftUI

struct NearestVetsView: View {
    @StateObject private var viewModel: NearestVetViewModel
    
    init(_ coordinator: any AppCoordinatorProtocol) {
        self._viewModel = StateObject(wrappedValue: NearestVetViewModel(coordinator))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    LoadingView()
                } else if let errorMessage = viewModel.errorMessage {
                    ErrorView(message: errorMessage)
                } else if viewModel.filteredVets.isEmpty {
                    NoFoundView()
                } else {
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(viewModel.transformDTOToVets(), id: \.vet_id) { vet in
                                VetCardComponentView(vet: vet)
                                    .padding(.bottom)
                                    .onTapGesture {
                                        viewModel.goToDetails(.goToDetails(vetId: vet.vet_id, vetDistance: vet.vet_distance))
                                    }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Klinik Terdekat")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.goToDetails(.goToProfile)
                    }) {
                        Image(systemName: "person.circle")
                            .font(.title)
                    }
                }
            }
        }  .searchable(text: $viewModel.searchText)
            .refreshable {
                viewModel.onInput(.didFetchNearestVet)
            }
            .onAppear {
                viewModel.onInput(.didFetchNearestVet)
            }
    }
}
#Preview {
    @Previewable
    @StateObject var appCoordinator = AppCoordinator()
    NavigationStack(path: $appCoordinator.path) {
        NearestVetsView(appCoordinator)
            .navigationDestination(for: Screen.self) { screen in
                appCoordinator.build(screen)
            }
    }
}
