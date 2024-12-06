//
//  RegisterView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 04/12/24.
//


import SwiftUI

struct RegisterView: View {
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
            Text("Register")
                .font(.largeTitle)
                .padding(.top, 50)
                .bold()
            Spacer()
            Text("Nama Depan")
                .font(
                    Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                )
            TextField("Masukan Nama Depan", text: $viewModel.input.firstNameText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding(.bottom, 10)
            Text("Nama Belakang")
                .font(
                    Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                )
            TextField("Masukan Nama Belakang", text: $viewModel.input.lastNameText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding(.bottom, 10)
            
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
                viewModel.onInput(.DidTapRegister)
            }) {
                Text("Register")
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
                    viewModel.swiftLoginRegister(.DidTapLoginView)
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden()

    }
}

#Preview {
    RegisterView(AppCoordinator())
}
