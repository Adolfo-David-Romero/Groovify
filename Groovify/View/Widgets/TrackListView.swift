////
////  AlbumTrackView.swift
////  Groovify
////
////  Created by Kunal Bajaj on 2024-11-23.
////
//
//import SwiftUI
//
//struct TrackListView<Item: Tracks>: View {
//    var tracks: Item
//    var body: some View {
//        VStack(alignment: .leading, spacing: 16) {
//            Text("Tracks")
//                .font(.title2)
//                .bold()
//                .padding(.horizontal)
//            
//            ForEach(Array(tracks.items.enumerated()), id: \.offset) { index, playlistTrack in
//                if case .track(let track) = playlistTrack.track {
//                    HStack {
//                        Text("\(index + 1)")
//                            .foregroundColor(.gray)
//                            .frame(width: 30)
//                        
//                        VStack(alignment: .leading) {
//                            Text(track.name)
//                                .font(.body)
//                            Text(track.artists.map { $0.name }.joined(separator: ", "))
//                                .font(.caption)
//                                .foregroundColor(.gray)
//                        }
//                        Spacer()
//                        if let _ = track.preview_url {
//                            Image(systemName: "play.circle")
//                                .font(.title2)
//                        }
//                    }
//                    .padding(.horizontal)
//                    Divider()
//                }
//            }
//        }
//
//    }
//}
//
//
