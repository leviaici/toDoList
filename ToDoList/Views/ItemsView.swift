//
//  ItemsView.swift
//  ToDoList
//
//  Created by Adrian Leventiu on 10.08.2023.
//

import FirebaseFirestoreSwift
import SwiftUI

struct ItemsView: View {
    @StateObject var viewModel: ItemsViewViewModel
    @FirestoreQuery var items: [Item]
    @State private var selectedItem: Item?
    @State private var isModifyItemViewPresented = false

    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
        self._viewModel = StateObject(
            wrappedValue: ItemsViewViewModel(userId: userId)
        )
    }

    var overdueItems: [Item] {
        return items.filter { $0.dueDate < Date().timeIntervalSince1970 }
    }

    var upcomingItems: [Item] {
        return items.filter { $0.dueDate >= Date().timeIntervalSince1970 }
    }

    var body: some View {
        NavigationView {
            VStack {
                List {
                    if !overdueItems.isEmpty {
                        Section(header: Text("Overdue Items").foregroundColor(.appColor)) {
                            ForEach(overdueItems) { item in
                                showItems(item: item)
                            }
                        }
                    }
                    if !upcomingItems.isEmpty {
                        Section(header: Text("Upcoming items").foregroundColor(.appColor)) {
                            ForEach(upcomingItems) { item in
                                showItems(item: item)
                            }
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("My List")
            .toolbar {
                Button {
                    // Action of the button
                    viewModel.showingNewItemViewModel = true
                } label: {
                    Image(systemName: "plus")
                }.foregroundColor(.appColor)
            }
            .sheet(isPresented: $viewModel.showingNewItemViewModel) {
                NewItemView(newItemPresented: $viewModel.showingNewItemViewModel)
            }
        }
        .sheet(isPresented: Binding(
                        get: { isModifyItemViewPresented && selectedItem != nil },
                        set: { newValue in
                            isModifyItemViewPresented = newValue
                        }
        )) {
            if let selectedItem = selectedItem {
                ModifyItemView(item: selectedItem, modifiedItemPresented: $isModifyItemViewPresented)
            }
        }
    }

    func showItems(item: Item) -> some View {
        ItemView(item: item)
            .swipeActions(edge: .trailing) {
                Button {
                    viewModel.delete(id: item.id)
                } label: {
                    Image(systemName: "trash.fill")
                }.tint(.red)
            }
            .swipeActions(edge: .leading) {
                Button {
                    selectedItem = item
                    isModifyItemViewPresented = true
                } label: {
                    Image(systemName: "slider.horizontal.3")
                }
                .tint(.appColor)
            }
    }
}



struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView(userId: "4GYnXVlMCMR8LQ0JErKq1OPRTeh2")
    }
}
