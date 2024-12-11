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
                        ListView(title: "Your Recent Tracks", tracks: Array(homeViewModel.newReleases.shuffled().prefix(5)))
                        
                        // Top Charts Section
//                        SectionView(title: "Top Charts", items: Array(homeViewModel.newReleases.shuffled().prefix(5)))
                        
                        PlaylistCarouselView(
                            playlists: homeViewModel.newReleases.shuffled(),
                            title: "Top Charts",
                            onItemClick: { newRelease in
                                homeViewModel.loadAlbumData(for: newRelease.href)
                            }
                        )
                        .navigationDestination(item: $homeViewModel.selectedTopCharts) { albumData in
                            AlbumView(albumData: albumData)
                        }
                        
                        PlaylistCarouselView(
                            playlists: homeViewModel.newReleases.shuffled(),
                            title: "Featured Playlists",
                            onItemClick: { newRelease in
                                homeViewModel.loadAlbumData(for: newRelease.href)
                            }
                        )
                        .navigationDestination(item: $homeViewModel.selectedFeaturedPlaylist) { albumData in
                            AlbumView(albumData: albumData)
                        }
                        
                        // Deprecated by Spotify API
                        // Featured Playlists
//                        PlaylistCarouselView(
//                            playlists: homeViewModel.playlists,
//                            title: "Featured Playlists",
//                            onItemClick: { playlist in
//                                homeViewModel.loadPlaylistTracks(for: playlist)
//                            }
//                        )
//                        .navigationDestination(item: $homeViewModel.selectedPlaylistData) { playlistTracks in
//                            PlaylistView(playlists: playlistTracks)
//                        }

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
                        GenreSectionView(title: "Genres", genres: ["Pop", "Rock", "Hip-Hop", "Jazz", "Classical"])
                        
//                        SectionView(title: "Genres", items: Array(homeViewModel.newReleases.shuffled().prefix(5)))
                        
                    }
                }

                // MiniPlayer for music player
                MiniPlayerView()
            }
            .background(Color(red: 10.0 / 255.0, green: 14.0 / 255.0, blue: 69.0 / 255.0))
            .onAppear {
                homeViewModel.authenticateAndFetchData()
            }
        }
    }
}

#Preview {
    HomeView(showMenu: .constant(false)).environmentObject(MusicPlayerManager())
}
