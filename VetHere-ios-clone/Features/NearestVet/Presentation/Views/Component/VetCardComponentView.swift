//
//  VetCardComponentView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 05/12/24.
//

import SwiftUI

struct VetCardComponentView: View {
    let vet: Vet
    
    var body: some View {
        VStack(alignment: .leading) {
            ImageView(imageURL: vet.image, width: 361, height: 200)
            VStack(alignment: .leading, spacing: 8) {
                Text(vet.name)
                    .padding(.bottom, 2)
                    .font(.system(size: 22, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("TextColor"))
                
                HStack(spacing: 2) {
                    ForEach(0..<vet.rating, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 12))
                    }
                    ForEach(0..<(5 - vet.rating), id: \.self) { _ in
                        Image(systemName: "star")
                            .foregroundColor(.yellow)
                            .font(.system(size: 12))
                    }
                    
                    Text("•")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    
                    HStack {
                        Image(systemName: "map.fill")
                        Text("\(vet.range, specifier: "%.1f") Km")
                            .font(.system(size: 12))
                            .foregroundColor(Color("TextColor"))
                    }
                    
                    Text("•")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    
                    HStack {
                        Image(systemName: "clock.fill")
                        Text("\(vet.closeHour, specifier: "%.2f")")
                            .font(.system(size: 12))
                            .foregroundColor(Color("TextColor"))
                    }
                }
                
                Text(vet.address)
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
        vet: Vet(
            id: UUID(),
            name: "Vet Name",
            description: "Best vet in town",
            rating: 4,
            openHour: 8.0,
            closeHour: 17.0,
            image: "",
            range: 3.5,
            address: "Jalan Raya BSD",
            createdAt: Date(),
            updatedAt: Date(),
            distance: 0
        ))
}
