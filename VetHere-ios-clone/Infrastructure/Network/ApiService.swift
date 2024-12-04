//
//  ApiService.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

struct APIService {
    
    let baseURL: String = Constant.baseURLDev

    var method: NetworkManager.HTTPMethod = .GET
    
    var path: String = ""
    
    var headers: [String: Any]? = [:]
    
    var params: [String: Any]? = [:]
    
    var parameterEncoding: NetworkManager.EncodingType = .json
    
    var file: NetworkManager.File? = nil
}
