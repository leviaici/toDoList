//
//  ItemsView.swift
//  ToDoList
//
//  Created by Adrian Leventiu on 10.08.2023.
//

import SwiftUI

struct ItemsView: View {
    @StateObject var viewModel = ItemsViewViewModel()
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
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
        ItemsView(userId: "")
    }
}
