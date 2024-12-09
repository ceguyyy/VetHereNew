//
//  ChooseScheduleDTO.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

import Foundation

struct BookChooseScheduleRequestDto : Encodable {
    let vet_id: String
    let doctor_id: String
    let appointment_date: String
}

struct BookChooseScheduleResponseDTO: Decodable {
    let date: String
}
