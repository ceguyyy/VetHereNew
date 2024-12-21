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
                .padding(.top, 30)
                .bold()
                .padding(.horizontal,12)
                .padding(.bottom,50)
            Text("First Name")
                .font(
                    Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                ).padding(.horizontal,12)
            TextField("First name", text: $viewModel.input.firstNameText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding(.bottom, 10)
                .padding(.horizontal,12)
            Text("Last Name")
                .font(
                    Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                )
                .padding(.horizontal,12)
            TextField("Last name", text: $viewModel.input.lastNameText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding(.bottom, 10)
                .padding(.horizontal,12)
            
            Text("Username")
                .font(
                    Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                )
                .padding(.horizontal,12)
            TextField("username", text: $viewModel.input.usernameText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding(.bottom, 10)
                .padding(.horizontal,8)
            
            
            Text("Password")
                .font(
                    Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                ).padding(.horizontal,12)
            
            SecureField("******", text: $viewModel.input.passwordText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
                .padding(.horizontal,8)
            
            if viewModel.input.passwordValidation != nil{
                if !viewModel.input.passwordValidation!.isValid{
                    let message = viewModel.input.passwordValidation!.message
                    VStack {
                        Text(message)
                            .foregroundColor(.red)
                            .padding(.bottom, 10)
                    }.padding(.horizontal,12)
                }
            }
            Spacer()
            VStack(alignment: .center){
                HStack{
                    Spacer()
                    Text("Sudah punya akun? Login")
                        .foregroundColor(.blue)
                        .padding(.top, 10)
                    Spacer()
                }.onTapGesture {
                    viewModel.swiftLoginRegister(.DidTapLoginView)
                }
            }
            Button(action: {
                viewModel.onInput(.DidTapRegister)
            }) {
                Text("Register")
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
        RegisterView(appCoordinator)
            .navigationDestination(for: Screen.self) { screen in
                appCoordinator.build(screen)
            }
    }
}
