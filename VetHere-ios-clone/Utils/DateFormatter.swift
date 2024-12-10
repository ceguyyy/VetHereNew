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

func formattedDateToStringDDMMYYYY(_ dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd:MM:yyyy"
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    return dateFormatter.date(from: dateString)
}



func extractTime(from datetimeStr: String) -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    if let date = inputFormatter.date(from: datetimeStr) {
      
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "HH:mm:ss"

        return outputFormatter.string(from: date)
    } else {
       
        return nil
    }
}
