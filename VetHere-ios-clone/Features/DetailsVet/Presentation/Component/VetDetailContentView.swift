////
////  VetDetailContentView.swift
////  VetHere-ios-clone
////
////  Created by Christian Gunawan on 06/12/24.
////
//
//import SwiftUI
//
//struct VetDetailContentView: View {
//    let vetDetail: VetDetail
//    let vetDistance: Double
//    @Binding var selectedSegment: DetailEnum
//    let vetId: UUID
//    let viewmodel: VetDetailsViewModel
//    
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 20) {
//                ImageView(imageURL: vetDetail.image, width: 88, height: 88)
//                
//                VStack(alignment: .leading, spacing: 4) {
//                    Text(vetDetail.name)
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .padding(.horizontal)
//                    
//                    Text("\(vetDistance, specifier: "%.1f") Km")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                        .padding(.horizontal)
//                    
//                    Text("Buka sampai \(vetDetail.closeHour)")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                        .padding(.horizontal)
//                }
//                
//                Picker("Options", selection: $selectedSegment) {
//                    ForEach(DetailEnum.allCases) { segment in
//                        Text(segment.rawValue).tag(segment)
//                    }
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .padding(.horizontal)
//                
//                Group {
//                    switch selectedSegment {
//                    case .appointment:
//                        AppointmentViewComponent(vetDetail: vetDetail, vetId: vetId, viewmodel: viewmodel)
//                    case .information:
//                        InformationViewComponent(vetDetail: vetDetail)
//                    }
//                }
//            }
//        }
//    }
//}
