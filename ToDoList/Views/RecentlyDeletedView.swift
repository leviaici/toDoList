//
//  RecentlyDeletedView.swift
//  ToDoList
//
//  Created by Adrian Leventiu on 17.09.2023.
//

import FirebaseFirestoreSwift
import SwiftUI

struct RecentlyDeletedView: View {
    @StateObject var viewModel: RecentlyDeletedViewViewModel
    @FirestoreQuery var items: [Item]

    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
        self._viewModel = StateObject(
            wrappedValue: RecentlyDeletedViewViewModel(userId: userId)
        )
    }
    
    var shownItems: [Item] {
        return items.filter { $0.recentlyDeleted == true }
    }

    var body: some View {
        VStack {
            if !shownItems.isEmpty {
                Spacer()
                Spacer()
                Spacer()
                List(shownItems) { item in
                    showItems(item: item)
                }
            } else {
                Text("There are no recently deleted items.")
                    .bold()
            }
        }
        .navigationTitle("Recently Deleted")
        .listStyle(PlainListStyle())
        .toolbar {
            Button {
                viewModel.deleteAllItems()
            } label: {
                Text("Delete All")
            }.foregroundColor(.appColor)
        }
    }


    func showItems(item: Item) -> some View {
        ItemView(item: item, showCheck: false)
            .swipeActions(edge: .trailing) {
                Button {
                    viewModel.delete(id: item.id)
                } label: {
                    Image(systemName: "trash.fill")
                }.tint(.red)
            }
            .swipeActions(edge: .leading) {
                Button {
                    viewModel.recover(id: item.id)
                } label: {
                    Image(systemName: "gobackward")
                }
                .tint(.appColor)
            }
    }
}



struct RecentlyDeleted_Previews: PreviewProvider {
    static var previews: some View {
        RecentlyDeletedView(userId: "4GYnXVlMCMR8LQ0JErKq1OPRTeh2")
    }
}
