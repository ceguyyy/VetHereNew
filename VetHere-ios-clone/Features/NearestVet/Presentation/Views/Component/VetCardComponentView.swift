//
//  VetCardComponentView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 05/12/24.
//

import SwiftUI

struct VetCardComponentView: View {
    let vet: vets
    
    var body: some View {
        VStack(alignment: .leading) {
            ImageView(imageURL: vet.vet_image, width: 361, height: 200)
            VStack(alignment: .leading, spacing: 8) {
                Text(vet.vet_name)
                    .padding(.bottom, 2)
                    .font(.system(size: 22, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("TextColor"))
                
                HStack(spacing: 2) {
                    ForEach(0..<vet.vet_rating, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 12))
                    }
                    ForEach(0..<(5 - vet.vet_rating), id: \.self) { _ in
                        Image(systemName: "star")
                            .foregroundColor(.yellow)
                            .font(.system(size: 12))
                    }
                    
                    Text("•")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    
                    HStack {
                        Image(systemName: "map.fill")
                        Text("\(vet.vet_range, specifier: "%.1f") Km")
                            .font(.system(size: 12))
                            .foregroundColor(Color("TextColor"))
                    }
                    
                    Text("•")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    
                    HStack {
                        Image(systemName: "clock.fill")
                        Text("\(vet.vet_closeHour, specifier: "%.2f")")
                            .font(.system(size: 12))
                            .foregroundColor(Color("TextColor"))
                    }
                }
                
                Text(vet.vet_address)
                    .font(.system(size: 13))
                    .foregroundColor(Color("TextColor"))
                    .lineLimit(2)
            }
            .padding(12)
        }
        .frame(width: 361)
        .padding(.bottom)
        .foregroundColor(Color("TextColor"))
        .background(Color("ColorCard"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .cornerRadius(10)
    }
}

#Preview {
    VetCardComponentView(
        vet: vets(
            vet_id: UUID(),
            vet_name: "Vet Name",
            vet_description: "Best vet in town",
            vet_rating: 4,
            vet_openHour: 8.0,
            vet_closeHour: 17.0,
            vet_image: "",
            vet_range: 3.5,
            vet_address: "Jalan Raya BSD",
            createdAt: Date(),
            updatedAt: Date(),
            vet_distance: 0
        ))
}
