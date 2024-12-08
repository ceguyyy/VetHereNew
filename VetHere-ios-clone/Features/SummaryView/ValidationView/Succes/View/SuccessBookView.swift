//
//  SuccessBookView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 21/11/24.
//

import SwiftUI

struct SuccessBookView: View {
  @State private var scale: CGFloat = 1.0
  @StateObject private var viewModel: ValidationSummaryViewModel

  init(_ coordinator: any AppCoordinatorProtocol) {
    self._viewModel = StateObject(wrappedValue: ValidationSummaryViewModel(coordinator))

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
              .foregroundColor(Color.green)
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
            Image(systemName: "checkmark.circle.fill").resizable()
              .frame(width: 175, height: 175)
              .foregroundColor(.green)

          }

          VStack(alignment: .leading) {
            Text("Hore, Pemesanan Anda Berhasil! 🐾").padding(.vertical, 100).fontWeight(.bold)
              .font(.title)

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
    .navigationBarTitle("Booking Berhasil", displayMode: .inline)
    .cornerRadius(10)
    .padding()
  }
}

#Preview {
  @Previewable
  @StateObject var appCoordinator = AppCoordinator()
  NavigationStack(path: $appCoordinator.path) {
    SuccessBookView(appCoordinator)
      .navigationDestination(for: Screen.self) { screen in
        appCoordinator.build(screen)
      }
  }
}
