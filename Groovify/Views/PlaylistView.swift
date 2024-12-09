//
//  PlaylistView.swift
//  Groovify
//
//  Created by Kunal on 2024-11-21.
//

import SwiftUI

struct PlaylistView: View {
    
    /**
     This view displays the details of an playlists, including its cover image, name, artists, type, and total number of tracks.
     We navigate here from GetFeaturedPlaylists CarousalView present on the HomeScreen.
     */
    let playlists: PlaylistTracksWrapper
    
    // MARK: - Body
    var body: some View {
        
        /**
         Kind of redundant with AlbumView, but it was getting too complex to manage in a single view.
         In future we can try to refactor and extract the common code to a separate view.
         but for now, I decided to create a new base view for PlaylistView.
         */
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
                // Reusable component for displaying tracks
                TrackListView(tracks: trackItems)
            }
        }
    }
}
