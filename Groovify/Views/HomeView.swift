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
    @State private var BOOOL: Bool = true
    
    // For New Releases
    @State private var newReleases: [NewRelease] = []
    @State private var selectedNewRelease: NewRelease?
    
    @State private var selectedAlbumData: AlbumData?
    @State private var selectedPlaylistData: PlaylistTracksWrapper?
    @Environment(\.spotifyAPI) private var api
    
    // MARK: - Functions
    private func loadAlbumData(for href: String) {
        print("Loading album data for \(href)")
        if let range = href.range(of: "/v1/albums/") {
            let endpoint = "/albums/" + href[range.upperBound...]
            api.getAlbumData(endpoint: endpoint) { result in
                DispatchQueue.main.async {
                    switch result {
                        case .success(let data):
                            self.selectedAlbumData = data
                        case .failure(let error):
                            errorMessage = error.localizedDescription
                    }
                }
            }
        }
        
    }
    private func loadPlaylistTracks(for playlist: Playlist) {
        print("Loading playlist tracks for \(playlist.href)")
        if let range = playlist.href.range(of: "/v1/playlists/") {
            let endpoint = "/playlists/" + playlist.href[range.upperBound...] + "/tracks"
            api.getPlaylistTracks(endpoint: endpoint) { result in
                DispatchQueue.main.async {
                    switch result {
                        case .success(let data):
                            self.selectedPlaylistData = PlaylistTracksWrapper(
                                playlist: playlist,
                                tracks: data
                            )
                        case .failure(let error):
                            errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
    
    // MARK: - Body
    var body: some View {
        /**
         Changed sheet to navigation, as the sheet was not working as expected.
         Main issue was sheet was not able to navigate to TrackDetailsView, properly.
         */
        NavigationStack{
            VStack{
                TopBarView()
                ScrollView{
                    
                    /**
                     Placeholders for other components of the HomeView.
                     We can replace these with actual components later.
                     Might be a good idea to create separate views for each component.
                     
                     */
                    ListView(title: "Your Recent Tracks", tracks: ["Song1", "Song2", "Song3", "Song4", "Song5"])
                    SectionView(title: "Top Charts", items: ["Song1", "Song2", "Song3", "Song4", "Song5"])
                    
                    // Featured Playlists, this is a bit complex but reduces redundancy by a lot.
                    // It loads the playlist tracks on click. If we can implement a cache, it can be more efficient.
                    PlaylistCarouselView(playlists: playlists, title: "Featured Playlists", onItemClick: { playlist in
                        if let playlist = playlist as? Playlist {
                            loadPlaylistTracks(for: playlist)
                        }
                    })
                     // navigationDestination is a custom modifier to navigate to PlaylistView, it needs **Hashable** data.
                                    .navigationDestination(item: $selectedPlaylistData) { playlistTracks in
                                        PlaylistView(playlists: playlistTracks)
                                    }
                    // Same for New Releases
                    PlaylistCarouselView(playlists: newReleases, title: "New Releases", onItemClick: { playlist in
                        if let newRelease = playlist as? NewRelease {
                            selectedAlbumHref = newRelease.href
                            loadAlbumData(for: newRelease.href)
                        }
                    })
                    .navigationDestination(item: $selectedAlbumData) { albumData in
                        AlbumView(albumData: albumData)
                    }
                    
                    // Placeholders for other components of the HomeView.
                    SectionView(title: "Genres", items: ["Pop", "Rock", "Hip-Hop", "Jazz", "Classical"])
                    
                }
                // MiniPlayerView for music player.
                MiniPlayerView()
            }
            // Calling API calls for Featured Playlists and New Releases.
            // If user is not authenticated, it will show an error message.
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
}

#Preview {
    HomeView()
}
