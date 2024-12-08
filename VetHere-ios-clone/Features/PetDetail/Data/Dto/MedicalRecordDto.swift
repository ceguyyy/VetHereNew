//
//  MedicalRecordDto.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 08/12/24.
//

import Foundation

struct MedicalHistoryDetailResponseDto : Codable{
    let medical_record_detail_id : String
    let vet_name : String
    let diagnosis : String
    let treatment : String
    let created_at : String
}

struct MedicalHistorylResponseDto : Codable{
    let medical_record_id : String
    let medical_record_details : [MedicalHistoryDetailResponseDto]
}
