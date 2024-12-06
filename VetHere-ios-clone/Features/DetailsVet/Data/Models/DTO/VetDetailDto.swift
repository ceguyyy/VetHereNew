//
//  UserDto.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

struct vetDetailRequestDTO : Encodable {
    let vet_id: String
}

struct vetDetailResponseDTO: Decodable {
    let vet_id: String
    let vet_name: String
    let vet_description: String
    let vet_rating: Int
    let vet_open_hour: String
    let vet_close_hour: String
    let vet_image: String
    let vet_detail: VetDetailDTO
    let vet_doctors: [DoctorDTO]?
    let vet_facilities: [FacilityDTO]?
}

struct VetDetailDTO: Decodable {
    let vet_detail_id: String
    let vet_phone_number: String
    let vet_latitude: Double
    let vet_longitude: Double
}

struct DoctorDTO: Decodable {
    let doctor_id: String
    let doctor_name: String
    let doctor_rating: Int
    let specialization: SpecializationDTO
}

struct SpecializationDTO: Decodable {
    let specialization_id: String
    let specialization_name: String
}

struct FacilityDTO: Decodable {
    let facility_id: String
    let facility_name: String
}
