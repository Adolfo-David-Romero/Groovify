import SwiftUI

struct ListView: View {
    var title: String // Title of the list view
    
    // TODO: Replace this with a model for tracks
    // like Track(name: String, artist: String, duration: String, image: String)
    var tracks: [NewRelease] // Tracks to display in the list view
    //changes [String] to [NewRelease]
    
    var body: some View {
        VStack(alignment: .leading) {
            // Title on top of the list view
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            // Tracks list
            VStack(alignment: .leading, spacing: 10) {
                ForEach(tracks) { track in //tracks, id: \.self
                    HStack {
                        /**
                         TODO: Replace this with an image of the track or artist
                         */
                        Image(systemName: "music.note")
                            .foregroundColor(.blue)
                            .font(.title2)
                        
//                        Text(track)
//                            .font(.body)
//                            .foregroundColor(.primary)
                        Text(track.name) // Access the song name from the NewRelease object
                               .font(.body)
                               .foregroundColor(.primary)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding(.top)
    }
}

//#Preview {
//    ListView(title: "Your Recent Tracks", tracks: ["Song1", "Song2", "Song3", "Song4", "Song5"])
//}
#Preview {
    ListView(title: "Your Recent Tracks", tracks: [
        NewRelease(album_type: "", id: "", name: "Song 1", images: [], release_date: "", href: ""),
        NewRelease(album_type: "", id: "", name: "Song 2", images: [], release_date: "", href: ""),
    ])
}
