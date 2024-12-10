//
//  HomeView.swift
//  Groovify
//
//  Created by Kunal on 2024-11-11.
//

import SwiftUI

//MARK: - HOME SCREEN

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel

    @Binding var showMenu: Bool

    var body: some View {
        NavigationStack {
            VStack {
                TopBarView()

                ScrollView {
                    VStack(spacing: 20) {
                        // Recent Tracks
//                        ListView(title: "Your Recent Tracks", tracks: [homeViewModel.newReleases.name]) //"Song1", "Song2", "Song3", "Song4", "Song5"
                        ListView(title: "Your Recent Tracks", tracks: Array(homeViewModel.newReleases.prefix(5)))
                        
                        // Top Charts Section
                        SectionView(title: "Top Charts", items: ["Song1", "Song2", "Song3", "Song4", "Song5"])

                        // Featured Playlists
                        PlaylistCarouselView(
                            playlists: homeViewModel.playlists,
                            title: "Featured Playlists",
                            onItemClick: { playlist in
                                homeViewModel.loadPlaylistTracks(for: playlist)
                            }
                        )
                        .navigationDestination(item: $homeViewModel.selectedPlaylistData) { playlistTracks in
                            PlaylistView(playlists: playlistTracks)
                        }

                        // New Releases
                        PlaylistCarouselView(
                            playlists: homeViewModel.newReleases,
                            title: "New Releases",
                            onItemClick: { newRelease in
                                homeViewModel.loadAlbumData(for: newRelease.href)
                            }
                        )
                        .navigationDestination(item: $homeViewModel.selectedAlbumData) { albumData in
                            AlbumView(albumData: albumData)
                        }

                        // Genres Section
                        SectionView(title: "Genres", items: ["Pop", "Rock", "Hip-Hop", "Jazz", "Classical"])
                    }
                }

                // MiniPlayer for music player
                MiniPlayerView()
            }
            .onAppear {
                homeViewModel.authenticateAndFetchData()
            }
        }
    }
}

#Preview {
    HomeView(showMenu: .constant(false)).environmentObject(MusicPlayerManager())
}
