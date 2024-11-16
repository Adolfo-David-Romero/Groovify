//
//  FeaturedPlaylists.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-11-16.
//

import Foundation

struct FeaturedPlaylistsResponse: Decodable {
    let playlists: PlaylistResults
}

struct PlaylistResults: Decodable {
    let items: [Playlist]
}

struct Playlist: Decodable, Identifiable {
    let collaborative: Bool
    let description: String
    let id: String
    let images: [SpotifyImage]
    let name: String
    let tracks: PlaylistTrackResults
    
}
extension Playlist: CarouselItem {}


struct PlaylistTrackResults: Decodable {
    let href: String
    let total: Int
    
}
