//
//  ModifyItemView.swift
//  ToDoList
//
//  Created by Adrian Leventiu on 07.09.2023.
//

import SwiftUI

struct ModifyItemView: View {
    @Binding var viewModel: ModifyItemViewViewModel
    @Binding var modifiedItemPresented: Bool
    
    
    init(item: Item, modifiedItemPresented: Binding<Bool>) {
            _viewModel = .constant(ModifyItemViewViewModel(item: item))
            _modifiedItemPresented = modifiedItemPresented
        }
    
    var body: some View {
        VStack {
            Text("Edit Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 30)
            
            Form {
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                TLButton(title: "Edit", background: .appColor) {
                    if viewModel.canModify {
                        viewModel.modify()
                        modifiedItemPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"),
                      message: Text("Please be sure that you leave no empty fields and select a due date that it's later than today."))
            }
        }
    }
}

struct ModifyItemView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyItemView(item: Item(
            id: UUID().uuidString,
            title: "title",
            dueDate: Date().timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: false,
            recentlyDeleted: false
            ), modifiedItemPresented: Binding(get: {
                return true
            }, set: { _ in
            })
        )
    }
}
