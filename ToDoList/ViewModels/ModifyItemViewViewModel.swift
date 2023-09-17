//
//  ModifyItemViewViewModel.swift
//  ToDoList
//
//  Created by Adrian Leventiu on 07.09.2023.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class ModifyItemViewViewModel: ObservableObject {
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    private var item: Item
    
    init(item: Item) {
        self.title = item.title
        self.dueDate = Date(timeIntervalSince1970: item.dueDate)
        self.item = item
    }
    
    func modify() {
        guard canModify else {
            return
        }
        
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        // Modify model
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(item.id)
            .setData(["title": self.title, "dueDate": self.dueDate.timeIntervalSince1970, "createdDate": Date().timeIntervalSince1970, "recentlyDeleted": false], merge: true) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated")
                }
            }
    }
    
    var canModify: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard dueDate >= Date().addingTimeInterval(-86400) else { // 86400 seconds in a day
            return false
        }
        
        return true
    }
}
