//
//  VetImageView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

import SwiftUI


struct ImageView: View {
    let imageURL: String?
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        if let imageURL = URL(string: imageURL ?? "") {
            AsyncImage(url: imageURL) { image in
                image.resizable()
                    .frame(width: width, height: height)
                   
            } placeholder: {
                LoadingView()
            }
        } else if let imageURL = URL(string: Constant.ErrorImage) {
            AsyncImage(url: imageURL) { image in
                image.resizable()
                    .frame(width: width, height: height)
                   
            } placeholder: {
                LoadingView()
            }
        }
    }
}

struct PlaceholderImageView: View {
    var body: some View {
        Image(systemName: "photo.fill")
            .resizable()
            .frame(width: 393, height: 216)
            .foregroundColor(.gray)
    }
}
