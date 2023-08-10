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
}

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView(title: "To Do List", subtitle: "Never forget things again", angle: 30, background: .coralPink)
                
                // Login
                Form {
                    TextField("Email Address", text: $email)
                        .textFieldStyle(DefaultTextFieldStyle()).bold()
                    SecureField("Password", text: $password)
                        .textFieldStyle(DefaultTextFieldStyle()).bold()
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.coralPink)
                            Text("Login")
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                    .padding()
                }
                .padding(.bottom, 30)
                
                // Create Account
                VStack {
                    Text("New here?")
                    NavigationLink("Create an Account",
                                   destination: RegisterView())
                    .foregroundColor(.coralPink)
                        
                }.padding(.bottom, 30)
                
                Spacer()
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
