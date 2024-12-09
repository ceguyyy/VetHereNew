//
//  SummaryService.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 08/12/24.
//

import Foundation

internal struct BookSummaryService {
  static func sendAppointment(
    params: summaryRequestDTO
  ) -> APIService {
    let path = "/appointment"

    return APIService(
      method: .POST,
      path: path,
      headers: nil,
      params: params.toDictionary(),
      parameterEncoding: .json
    )
  }

}
