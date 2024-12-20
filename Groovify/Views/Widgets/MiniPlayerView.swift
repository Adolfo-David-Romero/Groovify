//
//  MiniPlayerView.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-11-12.
//

import SwiftUI
import Combine

struct MiniPlayerView: View {
    
    /**
        EnvironmentObject property wrapper is used to inject the MusicPlayerManager instance into the view.
     */
    @EnvironmentObject var playerManager: MusicPlayerManager
    
    var body: some View {
        if let track = playerManager.currentTrack {
            
            
            HStack {
                // Track Image or Icon
                if let imageURL = track.album?.images.first?.url,
                let url = URL(string: imageURL) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                        case .failure(_):
                            Image(systemName: "music.note")
                                .foregroundColor(.white)
                        case .empty:
                            ProgressView()
                        @unknown default:
                            Image(systemName: "music.note")
                                .foregroundColor(.white)
                        }
                    }
                // It will display a default music icon if no image is available.
                // Ideally it is cases where song is from single album, so we need to display album image.
                } else {
                    Image(systemName: "music.note")
                        .font(.title)
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading) {
                    Text(track.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(track.artistNames)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                // Playback Controls
                HStack(spacing: 20) {
                    Button(action: playerManager.previous) {
                        Image(systemName: "backward.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    
                    // Play/Pause Button
                    Button(action: {
                        playerManager.isPlaying
                            ? playerManager.pause()
                            : playerManager.play(track: track)
                    }) {
                        Image(systemName: playerManager.isPlaying ? "pause.fill" : "play.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    
                    Button(action: playerManager.next) {
                        Image(systemName: "forward.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()
            .background(Color(red: 10.0/255.0, green: 14.0/255.0, blue: 69.0/255.0))
            .cornerRadius(20)
            .transition(.move(edge: .bottom))
            // Custom animation for mini player view, but commented out for now, as requires Equatable implementation for Track.
//            .animation(.default, value: playerManager.currentTrack)
        }
    }
}
