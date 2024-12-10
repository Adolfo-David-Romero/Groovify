//
//  OutputScreen.swift
//  Groovify
//
//  Created by Iman on 2024-11-07.
//

import SwiftUI
struct OutputScreen: View {
    var initialSearchText: String
    var tracks: [Track] // Pass tracks to display

    var body: some View {
        VStack {
            Text("Groovify Song List:")
                .foregroundColor(.white)

            Text("You entered: \(initialSearchText)")
                .foregroundColor(.white)
                .padding()

            TrackListView(tracks: tracks) // Use TrackListView to display tracks
        }
        .padding()
        .background(Color(red: 10.0 / 255.0, green: 14.0 / 255.0, blue: 69.0 / 255.0))
    }
}

#Preview {
    OutputScreen(initialSearchText: "Happy", tracks: [])
}
