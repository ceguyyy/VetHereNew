//
//  NoteView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

//
//  NoteView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

import SwiftUI

struct NoteView: View {
    @StateObject private var viewModel: NoteViewModel
    @State var notes: String = ""
    
    init(_ coordinator: any AppCoordinatorProtocol) {
        self._viewModel = StateObject(wrappedValue: NoteViewModel(coordinator))
    }
    
    var body: some View {
        VStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Komplain dan Penyakit Peliharaan")
                            .font(.headline)
                            .padding(.top)
                        
                        Divider()
                        
                        TextField("Masukkan catatan...", text: $notes)
                            .frame(height: 200)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                            .padding(.bottom)
                        
                        Text("Catatan: Pastikan untuk memberikan detail yang lengkap.")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.bottom)
                    }
                    .padding(.horizontal)
                }
                
            }
            
            VStack(spacing: 20){
                CustomButtonComponent(title: "Lanjutkan", action: {
                    print("Catatan Simpan")
                }, isDisabled: false, backgroundColor: .white, textColor: .accentColor)
            }.padding(.horizontal, 16)
                .padding(.bottom, 20)
        }
        .background(Color(.systemGray6))
        .navigationTitle("Masukkan Catatan")
        .navigationBarTitleDisplayMode(.inline)
      
    }
}

#Preview {
    @Previewable
    @StateObject var appCoordinator = AppCoordinator()
    NavigationStack(path: $appCoordinator.path) {
        NoteView(appCoordinator)
            .navigationDestination(for: Screen.self) { screen in
                appCoordinator.build(screen)
            }
    }
}
