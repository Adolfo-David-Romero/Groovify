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
                
                TrackListView(tracks: albumData.tracks.items)
            }
        }
    }
}
