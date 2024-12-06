//
//  AuthenticationService.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

internal struct VetService {
  static func NearestVet(
    params: NearestRequestDto
  ) -> APIService {
    let path = "/vet/nearest-vets"

    return APIService(
      method: .POST,
      path: path,
      headers: nil,
      params: params.toDictionary(),
      parameterEncoding: .json
    )
  }

}
