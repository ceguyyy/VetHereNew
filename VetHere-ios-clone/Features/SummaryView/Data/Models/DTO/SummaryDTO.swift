//
//  SummartyDTO.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 08/12/24.
//

struct summaryRequestDTO : Encodable {
    let vet_id: String
    let doctor_id: String
    let pet_id: String
    let appointment_notes: String
    let appointment_date: String
    let appointment_time: String
}

struct summaryResponseDTO : Decodable {
    let vet_name: String
    let doctor_name: String
    let pet_name: String
    let appointment_notes: String
    let appointment_date: String
    let appointment_time: String
}
