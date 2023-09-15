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
        
    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
        self._viewModel = StateObject(
            wrappedValue: ItemsViewViewModel(userId: userId)
        )
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
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
                                viewModel.showingModifiedItemViewModel = true
                            } label: {
                                Image(systemName: "slider.horizontal.3")
                            }
                            .tint(.appColor)
                        }
                        .sheet(isPresented: $viewModel.showingModifiedItemViewModel) {
                                ModifyItemView(item: item, modifiedItemPresented:  $viewModel.showingModifiedItemViewModel)
                            }
                }
                .listStyle(PlainListStyle())
                .padding(.top, 20)
            }
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
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView(userId: "4GYnXVlMCMR8LQ0JErKq1OPRTeh2")
    }
}
