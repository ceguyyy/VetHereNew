//
//  WhatsAppManager.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 05/12/24.
//


import SwiftUI
import UIKit

func openWhatsApp(phoneNumber: String, message: String) {
        guard !phoneNumber.isEmpty else {
            print("Error: Phone number is empty.")
            return
        }
        
        let encodedMessage = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? message
        if let url = URL(string: "https://wa.me/\(phoneNumber)?text=\(encodedMessage)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("Error: Unable to open WhatsApp.")
        }
    }
