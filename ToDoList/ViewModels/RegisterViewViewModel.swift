//
//  RegisterViewViewModel.swift
//  ToDoList
//
//  Created by Adrian Leventiu on 10.08.2023.
//

import FirebaseAuth
import Foundation

class RegisterViewViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
//    @Published var passwordVerification = ""
    
    init(){}
    
    func register() {
        guard validate() else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userID = result?.user.uid else {
                return
            }
            self?.insertUserRecord(id: userID)
        }
    }
    
    private func insertUserRecord(id: String) {
        
    }
    
    private func validate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            return false
        }
        
        guard password.count >= 6 else {
            return false
        }
        
        return true
    }
}
