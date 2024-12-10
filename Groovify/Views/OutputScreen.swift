//
//  OutputScreen.swift
//  Groovify
//
//  Created by Iman on 2024-11-07.
//
import SwiftUI
struct OutputScreen: View {
    var initialSearchText: String
    var tracks: [Track] // Pass the tracks

    var body: some View {
        NavigationStack {
            VStack {
                Text("Groovify Song List:")
                    .foregroundColor(.white)

                Text("You entered: \(initialSearchText)")
                    .foregroundColor(.white)

                Text("Here are some songs to groove along to:")
                    .font(.headline)
                    .padding(.bottom, 20)
                    .foregroundColor(.white)

                // Use TrackListView to display tracks
                if !tracks.isEmpty {
                    ScrollView {
                        TrackListView(tracks: tracks)
                    }
                } else {
                    Text("No tracks found")
                        .foregroundColor(.red)
                }
            }
            .padding()
            .background(Color(red: 10.0 / 255.0, green: 14.0 / 255.0, blue: 69.0 / 255.0))
        }
    }
}
