//
//  OutputScreen.swift
//  Groovify
//
//  Created by Iman on 2024-11-07.
//

import SwiftUI
struct OutputView: View {
    var initialSearchText: String
    var tracks: [Track] // Pass tracks to display

    var body: some View {
        VStack {
            Text("Songs based on your mood")
                .foregroundColor(.white)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal)
                

            Text("You entered: \(initialSearchText)")
                .foregroundColor(.white)
                .padding()
            
            ScrollView {
                TrackListView(tracks: tracks) // Use TrackListView to display tracks
            }
        }
        .padding()
        .background(Color(red: 10.0 / 255.0, green: 14.0 / 255.0, blue: 69.0 / 255.0))
    }
}

#Preview {
    OutputView(initialSearchText: "Happy", tracks: [])
}
