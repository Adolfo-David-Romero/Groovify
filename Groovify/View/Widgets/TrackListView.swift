import SwiftUI

// MARK: - TrackListView (Reusable Component)
struct TrackListView<T: TrackDisplayable>: View {
    
    /**
        A view that displays a list of tracks. It takes an array of items conforming to `TrackDisplayable` protocol.
        The view displays the track name, artist names, and a play button if a preview URL is available.
     */
    
    // MARK: - Properties
    /*
        tracks: The array of items to display in the list.
        selectedTrack: The selected track to display in the detail view sheet.
     */
    let tracks: [T]
    @State private var selectedTrack: T? = nil // Track for the sheet
    
    // MARK: - Body
    var body: some View {
        
        // Simple list view for displaying tracks
        VStack(alignment: .leading, spacing: 16) {
            ForEach(Array(tracks.enumerated()), id: \.element.id) { index, track in
                HStack {
                    if let albumImageURL = track.album?.images.first?.url {
                        AsyncImage(url: URL(string: albumImageURL)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 50, height: 50)
                        }
                    } else {
                        Text("\(index + 1).")
                            .foregroundColor(.gray)
                            .frame(width: 50, height: 50)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                            .multilineTextAlignment(.center)
                    }

                    VStack(alignment: .leading) {
                        Text(track.name)
                            .font(.body)
                        Text(track.artistNames)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    if track.previewURL != nil {
                        Image(systemName: "play.circle")
                            .font(.title2)
                    }
                }
                .padding(.horizontal)
                // Show the detail view when tapped for each track
                .onTapGesture {
                    // Set the selected track and present the detail view
                    selectedTrack = track
                }
                Divider()
            }
        }
        // Present the detail view as a sheet
        .sheet(item: $selectedTrack) { track in
            TrackDetailView(track: track)
        }
    }
}
