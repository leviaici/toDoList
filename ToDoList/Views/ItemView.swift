//
//  ItemView.swift
//  ToDoList
//
//  Created by Adrian Leventiu on 10.08.2023.
//

import SwiftUI

struct ItemView: View {
    @StateObject var viewModel = ItemViewViewModel()
    let item: Item
    var showCheck: Bool = true
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .bold()
                Text("Due: \(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
            }
            
            Spacer()
            if(showCheck) {
                Button {
                    viewModel.toggleIsDone(item: item)
                } label: {
                    Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle").foregroundColor(.appColor)
                }
            }
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: .init(id: "123",
                             title: "Start learning!",
                             dueDate: Date().timeIntervalSince1970,
                             createdDate: Date().timeIntervalSince1970,
                             isDone: true, recentlyDeleted: false))
    }
}
