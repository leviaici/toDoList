//
//  RegisterView.swift
//  ToDoList
//
//  Created by Adrian Leventiu on 10.08.2023.
//

import SwiftUI

struct RegisterView: View {
    @State var name = ""
    @State var email = ""
    @State var password = ""
//    @State var passwordVerification = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView(title: "To Do List", subtitle: "Account registration", angle: -30, background: .cuteBlue)
                
                // Login
                Form {
                    TextField("Full name", text: $name)
                        .textFieldStyle(DefaultTextFieldStyle()).bold()
                    TextField("Email Address", text: $email)
                        .textFieldStyle(DefaultTextFieldStyle()).bold()
                    SecureField("Password", text: $password)
                        .textFieldStyle(DefaultTextFieldStyle()).bold()
//                    SecureField("Verify your password", text: $passwordVerification)
//                        .textFieldStyle(DefaultTextFieldStyle()).bold()
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.cuteBlue)
                            Text("Create Account")
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                    .padding()
                }
                
                // Create Account
                VStack {
                    Text("Already have an Account?")
                    NavigationLink("Login",
                                   destination: LoginView())
                    .foregroundColor(.cuteBlue)
                }.padding(.bottom, 30)
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
