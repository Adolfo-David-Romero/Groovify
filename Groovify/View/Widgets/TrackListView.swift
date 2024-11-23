import SwiftUI

struct TrackListView<T: TrackDisplayable>: View {
    let tracks: [T]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(Array(tracks.enumerated()), id: \.element.id) { index, track in
                HStack {
                    Text("\(index + 1).")
                        .foregroundColor(.gray)
                        .frame(width: 30)

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
                Divider()
            }
        }
    }
}
