//
//  AlbumView.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-11-21.
//

import SwiftUI

struct AlbumView: View {
    /**
     This view displays the details of an album, including its cover image, name, artists, type, and total number of tracks.
     We navigate here from NewReleases CarousalView present on the HomeScreen.
     */
    let albumData: AlbumData
    
    // MARK: - Body
    var body: some View {
        /**
         I know it might be a bit redundant with PlaylistView, but it was getting too complex to manage in a single view.
         So instead I decided to create a new base view for AlbumView.
         And extract the TrackListView to a separate view, as it can be reused in other views as well.
         */
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let coverImage = albumData.images.first {
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
                    Text(albumData.name)
                        .font(.title)
                        .bold()
                    
                    Text(albumData.artists.map { $0.name }.joined(separator: ", "))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("\(albumData.album_type.capitalized) • \(albumData.total_tracks) tracks")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                // Extracted TrackListView
                TrackListView(tracks: albumData.tracks.items)
            }
        }
    }
}
