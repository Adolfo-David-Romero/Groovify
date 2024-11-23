import SwiftUI

struct TrackListView<T: TrackDisplayable>: View {
    let tracks: [T]
    
    var body: some View {
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
                Divider()
            }
        }
    }
}
