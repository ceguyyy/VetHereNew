//
//  VaccineDto.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 08/12/24.
//

import Foundation

struct VaccineHistorylResponseDto : Codable{
    let vaccine_history_id : String
    let vaccine_histories_details : [VaccineHistoryDetailResponseDto]
 
}


struct VaccineHistoryDetailResponseDto : Codable{
    let vaccine_history_detail_id : String
    let vet_name : String
    let vaccine_name : String
    let created_at : String
}



