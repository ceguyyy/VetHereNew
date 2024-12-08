////
////  MyPetDetailView.swift
////  VetHere-ios-clone
////
////  Created by Andrew Oroh on 06/12/24.
////
//
//import SwiftUI
//
//struct MyPetDetailView: View {
//    @StateObject var viewModel : PetViewModel
//    let petId : String
//    init(
//        _ coordinator: any AppCoordinatorProtocol,
//        petId : String
//    ) {
//        self._viewModel = StateObject(
//            wrappedValue: PetViewModel(coordinator)
//        )
//        self.petId = petId
//    }
//    
//    var body: some View {
//        VStack{
//            ImageView(imageURL: viewModel.selectedPet?.petImage ?? "", width: 200, height: 200)
//            Text(viewModel.selectedPet?.petName ?? "Pet Name")
//                .font(.title)
//                .fontWeight(.bold)
//                .padding(.bottom,16)
//            HStack(spacing:24){
//                HStack{
//                    Image(systemName: "scalemass.fill")
//                    Text("\(viewModel.selectedPet?.petWeight ?? 2.4353, specifier: "%.2f"), Kg" )
//                }
//                HStack{
//                    Image(systemName: "pawprint.circle.fill")
//                    Text(viewModel.selectedPet?.petType ?? "pet type")
//                }
//            }
//            HStack(spacing:24){
//                HStack{
//                    Image(systemName: "calendar")
//                    Text(viewModel.selectedPet?.petDOB ?? "1/1/2021" )
//                }
//                HStack{
//                    Image(systemName: "cube.transparent.fill")
//                    Text(viewModel.selectedPet?.petType ?? "breed")
//                }
//                HStack{
//                    Image(systemName: "paintpalette.fill")
//                    Text(viewModel.selectedPet?.petType ?? "color")
//                }
//            }
//        }
//        .onAppear{
//            print("petId in detail view \(petId)")
//            viewModel.getUserPetDetail(petId: self.petId)
//        }
//    }
//}
//
//#Preview {
//    MyPetDetailView(AppCoordinator(),petId: "")
//}
