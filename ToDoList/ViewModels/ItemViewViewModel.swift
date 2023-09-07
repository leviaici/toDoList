//
//  ItemViewViewModel.swift
//  ToDoList
//
//  Created by Adrian Leventiu on 10.08.2023.
//

import FirebaseFirestore
import FirebaseAuth
import Foundation

class ItemViewViewModel: ObservableObject {
    @Published var showingModifiedItemViewModel = false
    init() {}
    
    func toggleIsDone(item: Item) {
        var copy = item
        copy.setDone(!item.isDone)
        
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(copy.id)
            .setData(copy.asDictionary())
    }
}
