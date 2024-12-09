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
            VStack {
                Text("Hello, \(authViewModel.currentUser?.fullname ?? "User")")
                    .font(.title2)
                    .foregroundColor(.white)
                Text("Ready to find your groove?")
                    .font(.caption)
                    .foregroundColor(.white)

            }
            Spacer()
            Button(action: {
                // Action for settings button,
                // e.g., navigate to settings screen
            }) {
                /**
                 TODO: Replace this with a custom settings icon or image for Groovify..
                 */
                NavigationLink(destination: UserProfileView().environmentObject(authViewModel)){
                    Image(systemName: "gearshape")
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
        }
        // Just added simple styling, feel free to customize further, I am not really good at this/:)
        .padding()
        .background(Color(red: 10.0/255.0, green: 14.0/255.0, blue: 69.0/255.0))
        // Rounded corners for the top bar,
        .cornerRadius(20)
        
    }
}

#Preview {
    TopBarView().environmentObject(AuthViewModel())
}
