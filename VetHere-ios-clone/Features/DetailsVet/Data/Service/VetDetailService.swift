//
//  AuthenticationService.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

internal struct VetDetailService {
  static func getVetDetail(
    params: vetDetailRequestDTO
  ) -> APIService {
    let path = "/vet/details"

    return APIService(
      method: .POST,
      path: path,
      headers: nil,
      params: params.toDictionary(),
      parameterEncoding: .json
    )
  }

}
