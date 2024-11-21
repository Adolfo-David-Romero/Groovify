//
//  AlbumView.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-11-21.
//

import SwiftUI

struct AlbumView: View {
    let albumData: AlbumData
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Album Header
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
                
                // Album Info
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
                
                // Tracks List
                VStack(alignment: .leading, spacing: 16) {
                    Text("Tracks")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                    
                    ForEach(albumData.tracks.items) { track in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(track.name)
                                    .font(.body)
                                Text(track.artists.map { $0.name }.joined(separator: ", "))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            if let previewUrl = track.preview_url {
                                // Add play button or preview functionality here
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
