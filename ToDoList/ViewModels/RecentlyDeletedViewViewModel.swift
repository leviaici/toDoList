//
//  RecentlyDeletedViewViewModel.swift
//  ToDoList
//
//  Created by Adrian Leventiu on 17.09.2023.
//

import FirebaseFirestore
import Foundation

class RecentlyDeletedViewViewModel: ObservableObject {
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
    
    func recover(id: String) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .setData(["recentlyDeleted": false], merge: true)
    }
    
    func deleteAllItems() {
        let db = Firestore.firestore()
        let todosRef = db.collection("users")
            .document(userId)
            .collection("todos")
            
        todosRef.whereField("recentlyDeleted", isEqualTo: true)
                .getDocuments { (querySnapshot, error) in
                    if let error = error {
                        print("Error getting documents: \(error)")
                    } else {
                        for document in querySnapshot!.documents {
                            let documentID = document.documentID
                            todosRef.document(documentID).delete { (error) in
                                if let error = error {
                                    print("Error deleting document: \(error)")
                                } else {
                                    print("Document successfully deleted")
                                }
                            }
                        }
                    }
                }
    }
}
