//
//  MenuView.swift
//  Groovify
//
//  Created by David on 2024-12-09.
//

import SwiftUI

///Hamburger menu that shows a welcome message, settings, user profile and etc.
struct MenuView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        VStack(alignment: .leading){
            // Menu Header
            HStack {
                ZStack {
                    if let user = authViewModel.currentUser {
                        Circle()
                            .fill(Color(.systemGray3))
                            .frame(width: 72, height: 72)
                            .overlay(
                                Text(user.initials)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            )
                    }
                }
                Text("Welcome, \(authViewModel.currentUser?.fullname ?? "")").font(.headline).foregroundColor(.white)
            }
            .padding(.top, 30)

            Divider()
            HStack{
                Image(systemName: "person").foregroundStyle(.white).imageScale(.large)
                NavigationLink(destination: UserProfileView().environmentObject(authViewModel)){
                    Text("Your Profile").foregroundStyle(.white).font(.headline)
                }
            }.padding(.top, 30)
            HStack{
                Image(systemName: "gear").foregroundStyle(.white).imageScale(.large)
                NavigationLink(destination: UserProfileView().environmentObject(authViewModel)){
                    Text("Settings").foregroundStyle(.white).font(.headline)
                }
                //TODO: Add adfitional Nav link here if needed
            }
            .padding(.top, 30)
            Spacer()
        }.padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 48.0 / 255.0, green: 44.0 / 255.0, blue: 124.0 / 255.0))
    }
}

#Preview {
    MenuView()
}
