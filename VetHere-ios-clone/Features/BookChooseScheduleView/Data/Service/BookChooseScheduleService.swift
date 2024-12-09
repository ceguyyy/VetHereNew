//
//  AuthenticationService.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

internal struct BookChooseScheduleService {
    static func getEmptySchedule(
        params: BookChooseScheduleRequestDto
    ) -> APIService {
        let path = "/doctor/empty-schedule"
        return APIService(
            method: .POST,
            path: path,
            headers: nil,
            params: params.toDictionary(),
            parameterEncoding: .json
        )
    }
}

