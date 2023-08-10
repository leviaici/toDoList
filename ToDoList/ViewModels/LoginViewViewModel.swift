//
//  LoginViewViewModel.swift
//  ToDoList
//
//  Created by Adrian Leventiu on 10.08.2023.
//

import FirebaseAuth
import Foundation

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func login() {
        guard validate() else {
            return
        }
        
        // Attempt to log in
        Auth.auth().signIn(withEmail: email, password: password)
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
}
