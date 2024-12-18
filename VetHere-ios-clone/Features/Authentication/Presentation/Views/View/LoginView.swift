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
                .padding(.top, 30)
                .bold()
                .padding(.horizontal,12)
                .padding(.bottom,50)
            
            Text("Username")
                .font(
                    Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                ).padding(.horizontal,12)
            TextField("Enter Your Username", text: $viewModel.input.usernameText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding(.bottom, 10)
                .padding(.horizontal,12)
            Text("Password")
                .font(
                    Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                )
                .padding(.horizontal,12)
            
            SecureField("******", text: $viewModel.input.passwordText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
                .padding(.horizontal,12)
            
            if viewModel.input.passwordValidation != nil{
                if !viewModel.input.passwordValidation!.isValid{
                    let message = viewModel.input.passwordValidation!.message
                    VStack{
                        Text(message)
                            .foregroundColor(.red)
                            .padding(.bottom, 10)
                    }
            
                        .padding(.horizontal,12)
                    
                }
            }
            Spacer()
            VStack(alignment: .center){
                HStack{
                    Spacer()
                    Text("Buat Akun")
                        .foregroundColor(.blue)
                        .padding(.top, 10)
                   
                    Spacer()
                }.onTapGesture {
                    viewModel.swiftLoginRegister(.DidTapRegisterView)
                }
            }
            Button(action: {
                viewModel.onInput(.DidTapLogin)
            }) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("AppOrange"))
                    .foregroundColor(.black)
                    .cornerRadius(8)
            }
            .padding(.bottom, 10)
            .padding()
           
        }
        .foregroundColor(Color("AppPrimary"))
        .background(Color("AppTertiary"))
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    @Previewable
    @StateObject var appCoordinator = AppCoordinator()
    NavigationStack(path: $appCoordinator.path){
        LoginView(appCoordinator)
            .navigationDestination(for: Screen.self) { screen in
                appCoordinator.build(screen)
            }
    }
}
