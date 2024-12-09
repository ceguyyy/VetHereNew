//
//  DetailsView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 04/12/24.
//

import SwiftUI
import Foundation

struct VetDetailsView: View {
    @StateObject private var viewmodel: VetDetailsViewModel
    @State private var selectedSegment: DetailEnum = .appointment
    
    let vetId: UUID
    let vetDistance: Double
    
    init(_ coordinator: any AppCoordinatorProtocol, vetId: UUID, vetDistance: Double) {
        self._viewmodel = StateObject(wrappedValue: VetDetailsViewModel(coordinator))
        self.vetId = vetId
        self.vetDistance = vetDistance
    }
    
    var body: some View {
        VStack {
            switch viewmodel.loadingState {
            case .loading:
                LoadingView()
            case .error(let message):
                ErrorView(message: message)
            case .loaded:
    
                if let vetDetail = viewmodel.vetDetail {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            ImageView(imageURL: vetDetail.image, width: 393, height: 216)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(vetDetail.name)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                
                                Text("\(vetDistance, specifier: "%.1f") Km")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                                
                                Text("Buka sampai \(vetDetail.closeHour)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                            }
                            
                            Picker("Options", selection: $selectedSegment) {
                                ForEach(DetailEnum.allCases) { segment in
                                    Text(segment.rawValue).tag(segment)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.horizontal)
                        
                            Group {
                                switch selectedSegment {
                                case .appointment:
                                    AppointmentViewComponent(vetDetail: vetDetail, vetId: vetId, viewmodel: viewmodel)
                                case .information:
                                    InformationViewComponent(vetDetail: vetDetail)
                                }
                            }
                        }
                    }
                } else {
                    NoFoundView()
                }
            }
        }
        .navigationBarTitle(viewmodel.vetDetail?.name ?? "Unknown")
        .onAppear {
            viewmodel.onInput(.didFetchDetailVet(vetid: vetId), vetId: vetId)
            
        }
        .refreshable {
            viewmodel.onInput(.didFetchDetailVet(vetid: vetId), vetId: vetId)
        }
    }
}


#Preview {
    @Previewable
    @StateObject var appCoordinator = AppCoordinator()
    NavigationStack(path: $appCoordinator.path) {
        VetDetailsView(appCoordinator, vetId: UUID(), vetDistance: 0)
            .navigationDestination(for: Screen.self) { screen in
                appCoordinator.build(screen)
            }
    }
}
