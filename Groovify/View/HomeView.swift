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
    
    private var api = SpotifyAPI()
    var body: some View {
        NavigationStack{
            VStack{
                TopBarView()
                ScrollView{
                    
                    ListView(title: "Your Recent Tracks", tracks: ["Song1", "Song2", "Song3", "Song4", "Song5"])
                    SectionView(title: "Top Charts", items: ["Song1", "Song2", "Song3", "Song4", "Song5"])
                    PlaylistCarouselView(playlists: playlists, title: "Featured Playlists", onItemClick: { playlist in
                        if let playlist = playlist as? Playlist {
                            loadPlaylistTracks(for: playlist)
                        }
                    })
                                    .navigationDestination(item: $selectedPlaylistData) { playlistTracks in
                                        PlaylistView(playlists: playlistTracks)
                                    }
                    PlaylistCarouselView(playlists: newReleases, title: "New Releases", onItemClick: { playlist in
                        if let newRelease = playlist as? NewRelease {
                            selectedAlbumHref = newRelease.href
                            loadAlbumData(for: newRelease.href)
                        }
                    })
                    .navigationDestination(item: $selectedAlbumData) { albumData in
                        AlbumView(albumData: albumData)
                    }
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
}

#Preview {
    HomeView()
}
