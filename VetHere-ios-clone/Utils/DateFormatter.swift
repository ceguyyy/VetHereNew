//
//  DateFormatter.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//


import SwiftUI

func formattedTimeHHMM(_ date: Date) -> String {
   let formatter = DateFormatter()
   formatter.dateFormat = "HH:mm"
   return formatter.string(from: date)
}

func formattedTimeDDMMYY(_ date: Date) -> String {
   let formatter = DateFormatter()
   formatter.dateFormat = "dd.MM.yyyy"
   return formatter.string(from: date)
}

func formattedDateYYYYMMDD(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd" 
    return formatter.string(from: date)
}

func formattedTimeHHMMSS(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "HH:mm:ss"
    return formatter.string(from: date)
}


