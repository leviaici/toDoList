//
//  Item.swift
//  ToDoList
//
//  Created by Adrian Leventiu on 10.08.2023.
//

import Foundation

struct Item: Codable, Identifiable {
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isDone: Bool
    var recentlyDeleted: Bool
    
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
    
    mutating func setRecentlyDeleted(_ state: Bool) {
        recentlyDeleted = state
    }
}
