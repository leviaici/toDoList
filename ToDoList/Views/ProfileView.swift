//
//  ProfileView.swift
//  ToDoList
//
//  Created by Adrian Leventiu on 10.08.2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.appColor)
                        .frame(width: 125, height: 125)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Name: ").bold()
                            Text(user.name)
                        }
                        
                        HStack {
                            Text("Email: ").bold()
                            Text(user.email)
                        }
                        
                        HStack {
                            Text("Member since: ").bold()
                            Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
                        }
                    }.padding()
                    
                    TLButton(title: "Log out", background: .appColor) {
                        viewModel.logout()
                    }
                    .padding(100)
                    
                    Spacer()
                } else {
                    Text("Loading profile...").padding(.top, 150)
                    TLButton(title: "Log out", background: .appColor) {
                        viewModel.logout()
                    }
                    .padding(.top, 100)
                    .padding(.bottom, 200)
                    
                    Spacer()
                }
            }
            .padding(.top, 75)
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fetch()
        }
    }
    
//    @ViewBuilder
//    func showProfile(user: User) -> some View {
//
//
//    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
