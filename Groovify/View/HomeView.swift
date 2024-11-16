//
//  HomeView.swift
//  Groovify
//
//  Created by Kunal on 2024-11-11.
//

import SwiftUI



struct HomeView: View {
    @State private var playlists: [Playlist] = []
    @State private var errorMessage: String?
    @State private var selectedPlaylist: Playlist?
    
    private var api = SpotifyAPI()
    var body: some View {
        VStack{
            TopBarView()
            ScrollView{
                
                ListView(title: "Your Recent Tracks", tracks: ["Song1", "Song2", "Song3", "Song4", "Song5"])
                SectionView(title: "Top Charts", items: ["Song1", "Song2", "Song3", "Song4", "Song5"])
                VStack(alignment: .leading) {
                    Text("Featured Playlists")
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
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                SectionView(title: "New Releases", items: ["Song1", "Song2", "Song3", "Song4", "Song5"])
                SectionView(title: "Genres", items: ["Pop", "Rock", "Hip-Hop", "Jazz", "Classical"])
                
            }
            MiniPlayerView(track: "Song1")
        }
        .onAppear {
            api.auth.authenticate { result in
                if case .failure(let error) = result {
                    errorMessage = error.localizedDescription
                } else {
                    api.getFeaturedPlaylists { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let playlists):
                                self.playlists = playlists
                            case .failure(let error):
                                errorMessage = error.localizedDescription
                            }
                        }
                    }
                    
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
