//
//  LoginView.swift
//  ToDoList
//
//  Created by Adrian Leventiu on 10.08.2023.
//

import SwiftUI
import UIKit

extension Color {
    static let coralPink = Color(red: 249/255, green: 157/255, blue: 140/255)
    static let cuteBlue = Color(red: 140/255, green: 157/255, blue: 249/255)
    static let appColor = Color(red: 236/255, green: 96/255, blue: 80/255)
}

struct LoginView: View {
    @State var viewModel = LoginViewViewModel()
    @State private var isKeyboardVisible = false
    @State private var showAlert = false
    
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
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Forgot your password?")
                            .onTapGesture {
                                popAlert()
                            }
//                            .alert(isPresented: $viewModel.showAlert) {
//                                Alert(
//                                    title: Text("Error"),
//                                    message: Text(viewModel.errorMessage),
//                                    dismissButton: .default(Text("OK"))
//                                )
//                            }
                            .foregroundColor(.coralPink)
                    }
                }
                .padding(.bottom, 10)
                
                Spacer()
            }
            .ignoresSafeArea(.keyboard)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.keyboard)
    }
    
    func popAlert() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
                return
        }
        
        let alert = UIAlertController(
            title: "E-mail",
            message: "Please, provide us the e-mail used for the account.",
            preferredStyle: .alert
        )

        alert.addTextField(
            configurationHandler: { textField in
                textField.placeholder = "your_e-mail@example.pls"
            })
        
        alert.addAction(UIAlertAction(
            title: "Send",
            style: .default,
            handler: { _ in
                if let emailTextField = alert.textFields?.first, let email = emailTextField.text {
                        // Pass the email to viewModel.reset()
                        viewModel.reset(email: email)
                    }
            }
        ))

        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        ))

        viewController.present(alert, animated: true, completion: nil)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
