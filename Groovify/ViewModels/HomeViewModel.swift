//
//  HomeViewModel.swift
//  Groovify
//
//  Created by David on 2024-12-09.
//

import SwiftUI

///ViewModel used to handle some logic side operations in the homeview
class HomeViewModel: ObservableObject {
    @Published var errorMessage: String?
    
    @Published var selectedAlbumHref: String? = nil
    // For Featured Playlists
    @Published var playlists: [Playlist] = []
    @Published var selectedPlaylist: Playlist?
    @Published var BOOOL: Bool = true
    
    // For New Releases
    @Published var newReleases: [NewRelease] = []
    @Published var selectedNewRelease: NewRelease?
    
    @Published var selectedAlbumData: AlbumData?
    @Published var selectedPlaylistData: PlaylistTracksWrapper?
    
    let api: SpotifyAPI

    init(api: SpotifyAPI) {
           self.api = api
       }
    
    func randomColor() -> Color {
       return Color(
         red: Double.random(in: 0...1),
         green: Double.random(in: 0...1),
         blue: Double.random(in: 0...1)
       )
     }
    
    func authenticateAndFetchData() {
        api.auth.authenticate { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            case .success:
                self.fetchFeaturedPlaylists()
                self.fetchNewReleases()
            }
        }
    }
    
    func fetchFeaturedPlaylists() {
        api.getFeaturedPlaylists { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    self.playlists = playlists
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchNewReleases() {
        api.getNewReleases { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let newReleases):
                    self.newReleases = newReleases
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func loadPlaylistTracks(for playlist: Playlist) {
        guard let range = playlist.href.range(of: "/v1/playlists/") else { return }
        let endpoint = "/playlists/" + playlist.href[range.upperBound...] + "/tracks"
        api.getPlaylistTracks(endpoint: endpoint) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.selectedPlaylistData = PlaylistTracksWrapper(playlist: playlist, tracks: data)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func loadAlbumData(for href: String) {
        guard let range = href.range(of: "/v1/albums/") else { return }
        let endpoint = "/albums/" + href[range.upperBound...]
        api.getAlbumData(endpoint: endpoint) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.selectedAlbumData = data
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
