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
                
                let trackItems = playlists.tracks.items.compactMap { playlistTrack -> Track? in
                    if case .track(let track) = playlistTrack.track {
                        return track
                    }
                    return nil
                }
                TrackListView(tracks: trackItems)
            }
        }
    }
}
