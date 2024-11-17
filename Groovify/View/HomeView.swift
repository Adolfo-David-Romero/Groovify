//
//  HomeView.swift
//  Groovify
//
//  Created by Kunal on 2024-11-11.
//

import SwiftUI



struct HomeView: View {
    @State private var errorMessage: String?
    
    @State private var selectedAlbumHref: String? = nil
    // For Featured Playlists
    @State private var playlists: [Playlist] = []
    @State private var selectedPlaylist: Playlist?
    
    // For New Releases
    @State private var newReleases: [NewRelease] = []
    @State private var selectedNewRelease: NewRelease?
    
    private func loadAlbumData(for href: String) {
        print("Loading album data for \(href)")
            api.getAlbumData(endpoint: "/albums/4aawyAB9vmqN3uQ7FjRGTy") { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        print("Album Data: \(data)") // Replace with your desired
                    case .failure(let error):
                        errorMessage = error.localizedDescription
                    }
                }
            }
        }
    
    private var api = SpotifyAPI()
    var body: some View {
        VStack{
            TopBarView()
            ScrollView{
                
                ListView(title: "Your Recent Tracks", tracks: ["Song1", "Song2", "Song3", "Song4", "Song5"])
                SectionView(title: "Top Charts", items: ["Song1", "Song2", "Song3", "Song4", "Song5"])
                PlaylistCarouselView(playlists: playlists, title: "Featured Playlists")
                PlaylistCarouselView(playlists: newReleases, title: "New Releases", onItemClick: { playlist in
                    if let newRelease = playlist as? NewRelease {
                        selectedAlbumHref = newRelease.href
                        loadAlbumData(for: newRelease.href)
                    }
                })
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
