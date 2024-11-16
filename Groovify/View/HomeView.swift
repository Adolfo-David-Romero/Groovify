//
//  HomeView.swift
//  Groovify
//
//  Created by Kunal on 2024-11-11.
//

import SwiftUI



struct HomeView: View {
    @State private var errorMessage: String?
    
    // For Featured Playlists
    @State private var playlists: [Playlist] = []
    @State private var selectedPlaylist: Playlist?
    
    // For New Releases
    @State private var newReleases: [Album] = []
    @State private var selectedAlbum: Album?
    
    private var api = SpotifyAPI()
    var body: some View {
        VStack{
            TopBarView()
            ScrollView{
                
                ListView(title: "Your Recent Tracks", tracks: ["Song1", "Song2", "Song3", "Song4", "Song5"])
                SectionView(title: "Top Charts", items: ["Song1", "Song2", "Song3", "Song4", "Song5"])
                PlaylistCarouselView(playlists: playlists, title: "Featured Playlists")
                PlaylistCarouselView(playlists: newReleases, title: "New Releases")
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
                    api.getNewReleases { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let newReleases):
                                    self.newReleases = newReleases
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
