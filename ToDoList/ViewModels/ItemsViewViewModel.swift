//
//  ItemsViewViewModel.swift
//  ToDoList
//
//  Created by Adrian Leventiu on 10.08.2023.
//

import FirebaseFirestore
import Foundation

class ItemsViewViewModel: ObservableObject {
    @Published var showingNewItemViewModel = false
    @Published var showingModifiedItemViewModel = false
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    func delete(id: String) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
}
