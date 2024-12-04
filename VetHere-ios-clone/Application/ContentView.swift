//
//  ContentView.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            NearestVetView()
                .tabItem {
                    Label("Klinik", systemImage: "house")
                }
            MyPetView()
                .tabItem {
                    Label("Peliharaan", systemImage: "pawprint.fill")
                }
                .tag(Screen.myPet)
            
            HistoryView()
                .tabItem {
                    Label("Riwayat", systemImage: "clock")
                }
                .tag(Screen.history)
        }
    }
}



#Preview {
    ContentView()
}
