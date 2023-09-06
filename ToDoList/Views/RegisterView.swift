//
//  RegisterView.swift
//  ToDoList
//
//  Created by Adrian Leventiu on 10.08.2023.
//

import SwiftUI

struct RegisterView: View {
    @State var viewModel = RegisterViewViewModel()
    @State private var isKeyboardVisible = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView(title: "To Do List", subtitle: "Account registration", angle: -30, background: .cuteBlue)
                
                // Login
                Form {
                    TextField("Full name", text: $viewModel.name)
                        .textFieldStyle(DefaultTextFieldStyle()).bold()
                        .autocorrectionDisabled()
                    
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle()).bold()
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle()).bold()
//                    SecureField("Verify your password", text: $viewModel.passwordVerification)
//                        .textFieldStyle(DefaultTextFieldStyle()).bold()
                    TLButton(title: "Create Account", background: .cuteBlue) {
                        // Attempt to register an account
                        viewModel.register()
                    }
                }
                .ignoresSafeArea(.keyboard)
                .padding(.top, isKeyboardVisible ? -175 : 0)
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                            withAnimation {
                                isKeyboardVisible = true
                            }
                        }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
                    withAnimation {
                        isKeyboardVisible = false
                    }
                }
                
                // Create Account
                VStack {
                    Text("Already have an Account?")
                    NavigationLink("Login",
                                   destination: LoginView())
                    .foregroundColor(.cuteBlue)
                }
                .padding(.bottom, 30)
                .ignoresSafeArea(.keyboard)
            }
            .ignoresSafeArea(.keyboard)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.keyboard)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
