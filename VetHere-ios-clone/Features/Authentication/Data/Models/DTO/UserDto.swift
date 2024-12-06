//
//  UserDto.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

struct LoginRequestDto : Encodable {
    let username: String
    let password: String
}

internal struct RegisterRequestDTO: Encodable {
    let username: String
    let password: String
    let firstName: String
    let lastName: String
}

internal struct AuthenticationResponseDTO: Codable {
    let access_token: String
    let refresh_token: String
}
