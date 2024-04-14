//
//  LoginViewViewModel.swift
//  ToDoList
//
//  Created by Adrian Leventiu on 10.08.2023.
//

import FirebaseAuth
import Foundation
import SwiftUI

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var showAlert = false
    
    init() {}
    
    func login() -> Bool {
        guard validate() else {
            return false
        }
        
        // Attempt to log in
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.errorMessage = "Login failed: \(error.localizedDescription)"
                self.showAlert = true
            }
        }
        return true
    }
    
    private func validate() -> Bool {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
                !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "You forgot one empty field."
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Enter valid email address."
            return false
        }
        
        return true
    }
    
    func reset(email: String) {
        let auth = Auth.auth()
        
        auth.sendPasswordReset(withEmail: email) { (error) in
//            if let error = error {
//                self.errorMessage = "This e-mail does not exist in our database. Please, check once again if you filled correctly the e-mail field."
//                self.showAlert = true
//            } else {
//                self.errorMessage = "An e-mail has been successfully sent to your address regarding the password reset!"
//                self.showAlert = true
//            }
        }
    }

}
