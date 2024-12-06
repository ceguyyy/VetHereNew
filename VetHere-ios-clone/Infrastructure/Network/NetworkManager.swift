//
//  ApiRequest.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

public class NetworkManager{
    static let shared = NetworkManager()
    private init() {}
    
    private let session = URLSession.shared
    private let credentialManager = KeychainCredentialManager.shared
    
    struct File {
        let data: Data
        let mimeType: String
        let filename: String
    }
    
    enum HTTPMethod: String {
        case GET
        case POST
        case PUT
        case PATCH
        case DELETE
    }
    
    enum EncodingType {
        case url
        case json
    }
    
    func makeRequest<T:Decodable>(_ request:APIService, output: T.Type) async -> Result<BaseResponse<T>, NetworkError>{
        var urlString = request.baseURL + request.path
        
        if request.method == .GET, let parameters = request.params, request.parameterEncoding == .url {
            urlString = encodeURL(urlString: urlString, parameters: parameters)
        }
        
        guard let url = URL(string: urlString) else {
            return .failure(NetworkError.invalidURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        if request.method != .GET, let parameters = request.params {
            do {
                switch request.parameterEncoding {
                case .json:
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                case .url:
                    let encodedParameters = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
                    urlRequest.httpBody = encodedParameters.data(using: .utf8)
                    urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                }
            } catch {
                return .failure(NetworkError.invalidParameters)
            }
        }
        
        if let credential = credentialManager.fetchCredential() {
            urlRequest.addValue("Bearer \(credential.accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        do {
            let (data, httpResponse) = try await URLSession.shared.data(for: urlRequest)
            debugPrint("Raw data response: \(String(describing: String(data: data, encoding: .utf8)))")
            
            let decoder = JSONDecoder()
            let response = try decoder.decode(BaseResponse<T>.self, from: data)
            
            debugPrint("aselole network \(response)")
            
            guard let httpResponse = httpResponse as? HTTPURLResponse else {
                if let error = response.meta.error {
                    throw NetworkError.errorResponse(error: error)
                }
                throw NetworkError.noData
            }
            
            if httpResponse.statusCode == 401 &&
                !request.path.contains("refresh") &&
                !request.path.contains("login") &&
                !request.path.contains("register")
            {
                return await refreshToken(
                    request,
                    output: output
                )
            }
            else if httpResponse.statusCode == 403{
                throw NetworkError.forbidden
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                if let error = response.meta.error {
                    throw NetworkError.errorResponse(error: error)
                }
                throw NetworkError.noData
            }
            
            return .success(response)
        }
        catch {
            debugPrint("network error \(error)")
            
            return .failure(
                NetworkError.genericError(error: error)
            )
        }
    }
    
    private func encodeURL(
        urlString: String,
        parameters: [String: Any]
    ) -> String {
        guard var components = URLComponents(string: urlString) else {
            return urlString
        }
        
        components.queryItems = parameters.map {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }
        
        return components.url?.absoluteString ?? urlString
    }
    
    private func refreshToken<T: Decodable>(
        _ request: APIService,
        output: T.Type
    ) async -> Result<BaseResponse<T>, NetworkError> {
        guard let credential = credentialManager.fetchCredential() else {
            return .failure(.errorResponse(error: "Invalid Credential"))
        }
        
        let params = [
            "refresh_token": credential.refreshToken
        ]
        
        let service = APIService(
            method: .POST,
            path: "/refresh",
            headers: nil,
            params: params,
            parameterEncoding: .json
        )
        
        let refreshResult = await makeRequest(
            service,
            output: AuthenticationResponseDTO.self
        )
        
        switch refreshResult {
        case .success(let result):
            guard let data = result.data else {
                return .failure(.noData)
            }
            
            credentialManager.setCredential(
                withToken: data.access_token,
                withRefreshToken: data.refresh_token
            )
            
            return await makeRequest(
                request,
                output: output
            )
        case .failure(let error):
            return .failure(error)
        }
    }
}
