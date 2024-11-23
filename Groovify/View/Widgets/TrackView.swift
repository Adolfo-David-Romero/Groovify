////
////  TrackView.swift
////  Groovify
////
////  Created by Kunal Bajaj on 2024-11-23.
////
//
//
//import SwiftUI
//import AVKit
//struct TrackDetailView: View {
//    var track: Track
//    @State private var player: AVPlayer?
//    @State private var isPlaying = false // Track playback state
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            if let albumImageUrl = track.album.images?.first?.url,
//               let url = URL(string: albumImageUrl) {
//                AsyncImage(url: url) { image in
//                    image
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(maxHeight: 200)
//                } placeholder: {
//                    ProgressView()
//                }
//            }
//
//            Text("Track: \(track.name)")
//                .font(.title)
//                .fontWeight(.bold)
//
//            Text("Artist(s): \(track.artists.map { $0.name }.joined(separator: ", "))")
//                .font(.headline)
//
//            Text("Album: \(track.album.name)")
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//
//            if let releaseDate = track.album.releaseDate {
//                Text("Release Date: \(releaseDate)")
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//            }
//
//            if let previewUrl = track.preview_url, let url = URL(string: previewUrl) {
//                Button(isPlaying ? "Pause Preview" : "Play Preview") {
//                    if isPlaying {
//                        player?.pause()
//                    } else {
//                        if player == nil {
//                            player = AVPlayer(url: url)
//                        }
//                        player?.play()
//                    }
//                    isPlaying.toggle()
//                }
//                .padding()
//                .background(isPlaying ? Color.red : Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(8)
//            } else {
//                Text("Preview not available")
//                    .foregroundColor(.secondary)
//            }
//
//            Spacer()
//        }
//        .padding()
//        .navigationTitle("Track Details")
//        .onDisappear {
//            player?.pause() // Stop playback when leaving the view
//            isPlaying = false
//        }
//    }
//}
//
