//
//  LoginView.swift
//  ToDoList
//
//  Created by Adrian Leventiu on 10.08.2023.
//

import SwiftUI

extension Color {
    static let coralPink = Color(red: 249/255, green: 157/255, blue: 140/255)
    static let cuteBlue = Color(red: 140/255, green: 157/255, blue: 249/255)
    static let appColor = Color(red: 236/255, green: 96/255, blue: 80/255)
}

struct LoginView: View {
    @State var viewModel = LoginViewViewModel()
    @State private var isKeyboardVisible = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView(title: "To Do List", subtitle: "Never forget things again", angle: 30, background: .coralPink)
                
                // Login
                Form {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle()).bold()
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle()).bold()
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    
                    TLButton(title: "Login", background: .coralPink) {
                        // Attempt to log in
                        viewModel.login()
                    }
                }
                .padding(.bottom, 30)
                .padding(.top, isKeyboardVisible ? -150 : 0)
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
                    Text("New here?")
                    NavigationLink("Create an Account",
                                   destination: RegisterView())
                        .foregroundColor(.coralPink)
                        
                }
                .padding(.bottom, 30)
                
                Spacer()
            }
            .ignoresSafeArea(.keyboard)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.keyboard)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
