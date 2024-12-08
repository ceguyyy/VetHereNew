//
//  Pet.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 06/12/24.
//

import Foundation

class Pet : Identifiable{
    let petId : String
    let petName : String
    let petType : String?
    let petImage : String?
    let petWeight : Double?
    let petDOB : String?
    let petBreed : String?
    let petColor : String?
    let medicalRecord : MedicalRecord?
    let vaccineHistory : [VaccineHistory]
    
    init(petId: String, petName: String, petType: String?, petImage: String?, petWeight:Double?, petDOB: String?, petBreed: String?, petColor: String?, medicalRecord : MedicalRecord?, vaccineHistory : [VaccineHistory]) {
        self.petId = petId
        self.petName = petName
        self.petType = petType
        self.petWeight = petWeight
        self.petImage = petImage
        self.petDOB = petDOB
        self.petBreed = petBreed
        self.petColor = petColor
        self.medicalRecord = medicalRecord
        self.vaccineHistory = vaccineHistory
        
    }
}
