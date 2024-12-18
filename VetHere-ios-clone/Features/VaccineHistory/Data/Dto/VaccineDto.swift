//
//  VaccineDto.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 08/12/24.
//

import Foundation

struct VaccineHistorylResponseDto : Codable{
    let vaccine_id : String
    let vaccine_name : String
    let vet_name : String
    let vaccine_date : String
}
