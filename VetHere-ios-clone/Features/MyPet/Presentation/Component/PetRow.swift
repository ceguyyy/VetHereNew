// PetRow.swift
import SwiftUI

struct PetRow: View {
    var pet: Pet
    var onTap: () -> Void

    var body: some View {
        HStack {
            ImageView(imageURL: pet.image, width: 50, height: 50).clipShape(Circle())

            VStack(alignment: .leading) {
                Text(pet.name).font(.body)
                Text(pet.type).font(.caption).foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
        .fontWeight(.bold)
        .cornerRadius(8)
        .onTapGesture {
            onTap()
        }
    }
}
