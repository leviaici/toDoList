//
//  User.swift
//  ToDoList
//
//  Created by Adrian Leventiu on 10.08.2023.
//

import Foundation

struct User: Codable {
    let id: String
    let email: String
    let name: String
    let joined: TimeInterval
}
