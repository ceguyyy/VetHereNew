//
//  FailedBookView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 21/11/24.
//

import SwiftUI

struct BookFailedView: View {

  @State private var scale: CGFloat = 1.0
  @StateObject private var viewModel: BookSuccesOrFailedViewModel

  init(_ coordinator: any AppCoordinatorProtocol) {
    self._viewModel = StateObject(wrappedValue: BookSuccesOrFailedViewModel(coordinator))
  }

  var body: some View {
    VStack {
      Text("Booking Gagal")
        .font(.title)
        .fontWeight(.bold)
        .padding(.top, 36)

      ZStack {

        Image("ValidationImage")
          .scaledToFit()
          .frame(width: 300, height: 300)

        VStack {
          ZStack {

            Image(systemName: "circle.fill")
              .resizable()
              .frame(width: 200, height: 200)
              .scaleEffect(scale)
              .foregroundColor(Color.red)
              .opacity(0.5)
              .onAppear {
                withAnimation(
                  Animation.spring(duration: 1.0).repeatForever(autoreverses: true)
                ) {
                  scale = 1.5
                }
              }

            Image(systemName: "circle.fill").resizable()
              .frame(width: 175, height: 175)
              .foregroundColor(.white)
            Image(systemName: "x.circle.fill").resizable()
              .frame(width: 175, height: 175)
              .foregroundColor(.red)

          }

          VStack(alignment: .leading) {
            Text("Ups, Pemesanan Anda Gagal! 🐾").padding(.vertical, 100).fontWeight(.bold)
              .font(.largeTitle)
          }

          Spacer()

        }

        VStack {
          Spacer()
          HStack {
            Spacer()
            Text("Kembali kehalaman utama")
              .foregroundColor(.white)
              .font(.headline)
            Spacer()
          }
          .padding()
          .background(Color.blue)
          .cornerRadius(8)
          .padding(.horizontal)
          .onTapGesture {
            viewModel.goToDetails(.goToSplah)
          }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 200)
      }

      Spacer()
    }
    .navigationBarBackButtonHidden()
    .navigationBarTitle("Booking Gagal", displayMode: .inline)
    .background(Color("Failed"))
    .cornerRadius(10)
    .padding()
  }
}

#Preview {
  @Previewable
  @StateObject var appCoordinator = AppCoordinator()
  NavigationStack(path: $appCoordinator.path) {
    BookFailedView(appCoordinator)
      .navigationDestination(for: Screen.self) { screen in
        appCoordinator.build(screen)
      }
  }
}
