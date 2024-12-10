//
//  HistoryService.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 10/12/24.
//

internal struct HistoryService {
    static func getHistory(
        params: GetHistoryRequestDto
    ) -> APIService {
        let path = "/appointment/user"
        return APIService(
            method: .GET,
            path: path,
            headers: nil,
            params: params.toDictionary(),
            parameterEncoding: .json
        )
    }
}

