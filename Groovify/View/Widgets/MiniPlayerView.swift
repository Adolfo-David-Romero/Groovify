//
//  MiniPlayerView.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-11-12.
//

import SwiftUI

struct MiniPlayerView: View {
    
    var track: String // Will be replaced with actual track model.
    
    var body: some View {
        HStack {
            // Profile Icon (Placeholder)
            Image(systemName: "music.note")
                .font(.title)
                .foregroundColor(.white)
            
            Text(track)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Spacer()
            HStack {
                Button(action: {
                    // Action for previous button
                }) {
                    Image(systemName: "backward.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                Button(action: {
                    // Action for play/pause button
                }) {
                    Image(systemName: "play.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                Button(action: {
                    // Action for next button
                }) {
                    Image(systemName: "forward.fill")
                        .font(.title2)
                    .foregroundColor(.white)}
            }
        }
        // basic styling, feel free to customize further
        .padding()
        .background(Color(red: 10.0/255.0, green: 14.0/255.0, blue: 69.0/255.0))
        // Rounded corners for the top bar,
        .cornerRadius(20)
        
    }
}

#Preview {
    MiniPlayerView(track: "Song1")
}
