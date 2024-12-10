//
//  HistoryView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 04/12/24.
//

import SwiftUI

struct HistoryView: View {
    @StateObject private var viewModel: HistoryViewModel
    @State private var showNewPetSheet: Bool = false

    init(_ coordinator: any AppCoordinatorProtocol) {
        self._viewModel = StateObject(wrappedValue: HistoryViewModel(coordinator))
    }

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    LoadingView()
                } else if viewModel.history.isEmpty {
                    NoFoundView()
                } else {
                    List {
                        Section(header: Text("Riwayat Pemesanan")) {
                            ForEach(viewModel.transformDTOtoHistory(), id: \.id) { history in
                                HStack {
                                    ImageView(imageURL: Constant.ErrorImage, width: 50, height: 50)
                                        .clipShape(Circle())

                                    VStack(alignment: .leading) {
                                        Text(history.vetName)
                                            .font(.body)
                                        Text(history.doctorName)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding(.vertical, 4)
                                .onTapGesture {
                                    viewModel.goToAction(.goToHistoryDetails(date: history.date, time: history.time, vetName: history.vetName, doctorName: history.doctorName, petName: history.petName, notes: history.notes))
                                }
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationTitle("Riwayat")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.goToAction(.goToProfile)
                    }) {
                        Image(systemName: "person.circle")
                            .font(.title)
                    }
                }
            }
            .refreshable {
                viewModel.onInput(.didFetchHistory)
            }
            .onAppear {
                viewModel.onInput(.didFetchHistory)
            }
        }
    }
}


#Preview {
    @Previewable
    @StateObject var appCoordinator = AppCoordinator()
    NavigationStack(path: $appCoordinator.path){
        HistoryView(AppCoordinator())
            .navigationDestination(for: Screen.self) { screen in
                appCoordinator.build(screen)
            }
    }
}
    
