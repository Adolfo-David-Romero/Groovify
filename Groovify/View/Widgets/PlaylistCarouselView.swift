import SwiftUI

struct PlaylistCarouselView<Item: CarouselItem>: View {
    
    var playlists: [Item]
    var title: String
    var onItemClick: ((Item) -> Void)? // Callback for click events
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(playlists) { playlist in
                        VStack(alignment: .leading) {
                            if let imageUrl = playlist.images.first?.url {
                                AsyncImage(url: URL(string: imageUrl)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Rectangle()
                                        .foregroundColor(.gray)
                                }
                                .frame(width: 150, height: 150)
                                .cornerRadius(8)
                            }
                            
                            Text(playlist.name)
                                .font(.caption)
                                .lineLimit(2)
                                .frame(width: 150)
                        }
                        .onTapGesture {
                            onItemClick?(playlist) // Call the callback when tapped
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
