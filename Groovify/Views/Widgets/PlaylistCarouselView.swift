import SwiftUI

// MARK: - PlaylistCarouselView (Reusable Component)
struct PlaylistCarouselView<Item: CarouselItem>: View {
    
    /**
        A view that displays a horizontal carousel of playlists. It takes an array of items conforming to `CarouselItem` protocol.
        The view displays the title and a horizontal scrollable list of items.
     
     */
    // MARK: - Properties
    /*
        playlists: The array of items to display in the carousel.
        title: The title of the carousel.
        onItemClick: A closure that is called when an item is clicked
     */
    var playlists: [Item]
    var title: String
    var onItemClick: ((Item) -> Void)? // Callback for click events
    
    // MARK: - Body
    var body: some View {
        
        // UI for the PlaylistCarouselView
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
                                .lineLimit(1)
                                .frame(width: 150)
                        }
                        // Call the onItemClick closure when tapped
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
