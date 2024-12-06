//
//  UserDto.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

struct NearestRequestDto : Encodable {
    let lattitude: Double
    let longitude: Double
}

struct NearestResponseDTO: Decodable {
    let vet: VetDto
    let vet_distance: Double
}

struct VetDto: Decodable {
    let vet_id: String
    let vet_name: String
    let vet_description: String
    let vet_rating: Int
    let vet_open_hour: String
    let vet_close_hour: String
    let vet_image: String
}
