//
//  HistoryDto.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 10/12/24.
//

import Foundation

struct GetHistoryRequestDto : Encodable {
}

struct GetHistoryResponseDTO: Decodable {
    let appointment_id: String
    let vet_name: String
    let doctor_name: String
    let pet_name: String
    let appointment_notes: String
    let appointment_date: String
    let appointment_time: String
}
