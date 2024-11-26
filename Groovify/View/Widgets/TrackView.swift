import SwiftUI
import AVKit

struct TrackDetailView: View {
    var track: any TrackDisplayable
    @State private var player: AVPlayer?
    @State private var isPlaying = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Album Image
            if let albumImageUrl = track.album?.images.first?.url,
               let url = URL(string: albumImageUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 200)
                } placeholder: {
                    ProgressView()
                }
            }
            
            // Track Information
            Text("Track: \(track.name)")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Artist(s): \(track.artistNames)")
                .font(.headline)
            
            Text("Album: \(track.album?.name ?? "")")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            // Audio Preview Controls
            if let url = track.previewURL {
                HStack {
                    Button(action: {
                        if isPlaying {
                            player?.pause()
                        } else {
                            if player == nil {
                                player = AVPlayer(url: url)
                            }
                            player?.play()
                        }
                        isPlaying.toggle()
                    }) {
                        Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                    
                    Text(isPlaying ? "Pause Preview" : "Play Preview")
                }
                .padding()
            } else {
                Text("Preview not available")
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Track Details")
        .onDisappear {
            player?.pause()
            isPlaying = false
        }
    }
}
