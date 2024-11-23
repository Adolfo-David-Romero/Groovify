//
//  PlaylistView.swift
//  Groovify
//
//  Created by Kunal on 2024-11-21.
//

import SwiftUI

struct PlaylistView: View {
    let playlists: PlaylistTracksWrapper
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Playlist Header
                if let coverImage = playlists.playlist.images.first {
                    AsyncImage(url: URL(string: coverImage.url)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 300)
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                // Playlist Info
                VStack(alignment: .leading, spacing: 8) {
                    Text(playlists.playlist.name)
                        .font(.title)
                        .bold()
                    
                    Text(playlists.playlist.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("\(playlists.tracks.items.count) tracks")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                // Tracks List
                VStack(alignment: .leading, spacing: 16) {
                    Text("Tracks")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                    
                    ForEach(Array(playlists.tracks.items.enumerated()), id: \.offset) { index, playlistTrack in
                        if case .track(let track) = playlistTrack.track {
                            HStack {
                                Text("\(index + 1)")
                                    .foregroundColor(.gray)
                                    .frame(width: 30)
                                
                                VStack(alignment: .leading) {
                                    Text(track.name)
                                        .font(.body)
                                    Text(track.artists.map { $0.name }.joined(separator: ", "))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                if let _ = track.preview_url {
                                    Image(systemName: "play.circle")
                                        .font(.title2)
                                }
                            }
                            .padding(.horizontal)
                            Divider()
                        }
                    }
                }
            }
        }
    }
} 
