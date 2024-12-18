//
//  LoginViewModel.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

class LoginViewModel:ObservableObject {
    private let networkManager = NetworkManager.shared
    private let authenticationDefaults = AuthenticationUserDefaults.shared
    private let credentialManager = KeychainCredentialManager.shared
    
    private let coordinator: any AppCoordinatorProtocol
    @Published var input: InputValue = InputValue()
    
    let locationManager = LocationManager()
       init(_ coordinator: any AppCoordinatorProtocol) {
           self.coordinator = coordinator
           self.locationManager.requestLocationPermission()
       }
    
    enum switchLoginRegister{
        case DidTapLoginView
        case DidTapRegisterView
    }
    
    enum InputGesture{
        case DidTapLogin
        case DidTapRegister
        
    }
    
    struct ValidationResult{
        var isValid: Bool
        var message : String
    }
    
    struct InputValue {
        var usernameText: String = ""
        var passwordText: String = ""
        var passwordValidation : ValidationResult?
        var firstNameText: String = ""
        var lastNameText: String = ""
    }
    
    
    func swiftLoginRegister(_ switchLoginRegister: switchLoginRegister){
        switch switchLoginRegister {
        case .DidTapRegisterView:
            print("did tap login view")
            coordinator.pop()
            coordinator.push(.register)
        case .DidTapLoginView:
            print("did tap register view")
            coordinator.pop()
            coordinator.push(.login)
        }
    }
    
    func onInput(_ inputGesture: InputGesture){
        switch inputGesture {
        case .DidTapLogin:
            print("did tap login")
            Task{@MainActor [weak self] in
                guard let self = self else { return }
                guard !self.input.usernameText.isEmpty, !self.input.passwordText.isEmpty else {
                    print("Username or password cannot be empty")
                    return
                }
                let dto = LoginRequestDto(username: self.input.usernameText, password: self.input.passwordText)
                let service = AuthenticationService.login(params: dto)
                let request = await networkManager.makeRequest(service, output: AuthenticationResponseDTO.self)
                let response = request.flatMap { response -> Result<Void, NetworkError> in
                    guard response.meta.success, let data = response.data else {
                        return .failure(.noData)
                    }
                    
                    credentialManager.setCredential(
                        withToken: data.access_token,
                        withRefreshToken: data.refresh_token
                    )
                    authenticationDefaults.saveIsVerified(true)
                    
                    return .success(())
                }
                switch response {
                case .success(_):
                    coordinator.pop()
                    print("saved access token : ", credentialManager.fetchCredential()?.accessToken as Any)
                    print("saved refresh token : ", credentialManager.fetchCredential()?.refreshToken as Any)
                    coordinator.push(.contentView)
                case .failure(_):
                    self.input.passwordValidation = ValidationResult(
                        isValid: false, message: "Incorrect Credentials, please try again"
                    )
                }
            }
        case .DidTapRegister:
            print("did tap register")
            Task {
                @MainActor [ weak self] in
                guard let self else { return }
                let dto = RegisterRequestDTO(username: self.input.usernameText, password: self.input.passwordText, first_name: self.input.firstNameText, last_name: self.input.lastNameText)
                guard !self.input.usernameText.isEmpty, !self.input.passwordText.isEmpty, !self.input.firstNameText.isEmpty else {
                    print("Username or password cannot be empty")
                    return
                }
                let service = AuthenticationService.register(params: dto)
                let request = await networkManager.makeRequest(service, output: AuthenticationResponseDTO.self)
                let response = request.flatMap { response -> Result<Void, NetworkError> in
                    guard response.meta.success, let data = response.data else {
                        return .failure(.noData)
                    }
                    return .success(())
                }

                switch response {
                case .success(_):
                    print("saved access token : ", credentialManager.fetchCredential()?.accessToken as Any)
                    print("saved refresh token : ", credentialManager.fetchCredential()?.refreshToken as Any)
                    coordinator.popToRoot()
                    coordinator.push(.login)
                case .failure(let error):
                    debugPrint("Failed registering: \(error.localizedDescription)")
                    self.input.passwordValidation = ValidationResult(
                        isValid: false,
                        message: "Registration failed, please check your credentials again"
                    )
                }
                }
                
            }
            
        }
    }
