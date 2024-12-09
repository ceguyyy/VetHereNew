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
            Text("First Name")
                .font(
                    Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                )
            TextField("First name", text: $viewModel.input.firstNameText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding(.bottom, 10)
            Text("Last Name")
                .font(
                    Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                )
            TextField("Last name", text: $viewModel.input.lastNameText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding(.bottom, 10)
            
            Text("Username")
                .font(
                    Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                )
            TextField("username", text: $viewModel.input.usernameText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding(.bottom, 10)
            
            
            Text("Password")
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
                    Text("Already have account? SignIn")
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
    @Previewable
    @StateObject var appCoordinator = AppCoordinator()
    NavigationStack(path: $appCoordinator.path){
        RegisterView(appCoordinator)
            .navigationDestination(for: Screen.self) { screen in
                appCoordinator.build(screen)
            }
    }
}
