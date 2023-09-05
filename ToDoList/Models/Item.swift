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
    
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}
