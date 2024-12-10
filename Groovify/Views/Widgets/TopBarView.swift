//
//  TopBarView.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-11-12.
//

import SwiftUI

struct TopBarView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        HStack {
            // Profile Icon (Placeholder)
            VStack (alignment: .leading, spacing: 4){
                Text("Hello, \(authViewModel.currentUser?.fullname ?? "User")")
                    .font(.title2)
                    .foregroundColor(.white)
                
                Text("Ready to find your groove?")
                    .font(.caption)
                    .foregroundColor(.white)
                    

            }
            .frame(maxWidth: .infinity, alignment: .leading) 
            Spacer()
            Button(action: {
                // Action for settings button,
                // e.g., navigate to settings screen
            }) {
                Image("groovify_icon")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 50, height: 50)
                
//                NavigationLink(destination: UserProfileView().environmentObject(authViewModel)){
//                    Image(systemName: "gearshape")
//                        .font(.title)
//                        .foregroundColor(.white)
//                }
            }
        }
        .padding()
        .background(Color(red: 48.0 / 255.0, green: 44.0 / 255.0, blue: 124.0 / 255.0))
        // Rounded corners for the top bar,
        .cornerRadius(10)
        
    }
}

#Preview {
    TopBarView().environmentObject(AuthViewModel())
}
