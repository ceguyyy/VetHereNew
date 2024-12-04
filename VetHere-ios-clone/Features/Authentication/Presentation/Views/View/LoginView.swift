//
//  LoginView.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel:LoginViewModel
    init(
        _ coordinator: any AppCoordinatorProtocol
    ) {
        self._viewModel = StateObject(
            wrappedValue: LoginViewModel(coordinator)
        )
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Login")
                .font(.largeTitle)
                .padding(.top, 50)
                .bold()
            Spacer()
            Text("Username")
                .font(
                    Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                )
            TextField("Masukan username", text: $viewModel.input.usernameText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding(.bottom, 10)
            Text("Kata Sandi")
                .font(
                    Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                )
            
            SecureField("******", text: $viewModel.input.passwordText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
            
            if viewModel.input.passwordValidation != nil{
                if !viewModel.input.passwordValidation!.isValid{
                    let message = viewModel.input.passwordValidation!.message
                    Text(message)
                        .foregroundColor(.red)
                        .padding(.bottom, 10)
                }
            }
            Spacer()
            Button(action: {
                viewModel.onInput(.DidTapLogin)
            }) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.black)
                    .cornerRadius(8)
            }
            .padding(.bottom, 10)
            VStack(alignment: .center){
                HStack{
                    Spacer()
                    Text("Belum Punya Account? Registrasi")
                        .foregroundColor(.blue)
                        .padding(.top, 10)
                    Spacer()
                }.onTapGesture {
                    viewModel.swiftLoginRegister(.DidTapRegisterView)
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    LoginView(AppCoordinator())
}
