//
//  DetailEnum.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 14/11/24.
//


enum DetailEnum: String, CaseIterable, Identifiable {
    case appointment = "Janji Temu"
    case information = "Informasi"
    
    var id: String { self.rawValue }
  }
