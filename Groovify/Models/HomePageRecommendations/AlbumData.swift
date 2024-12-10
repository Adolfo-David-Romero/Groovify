//
//  AlbumData.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-11-17.
//

import Foundation

// For GetAlbum Endpoint.
// MARK: - AlbumData
struct AlbumData: Decodable, Identifiable, Hashable {
    let album_type: String
    let id: String
    let name: String
    let images: [SpotifyImage]
    let total_tracks: Int
    let artists: [SimplifiedArtist]
    let tracks: Tracks
    
    // Hashable and Equatable conformance for navigation
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        static func == (lhs: AlbumData, rhs: AlbumData) -> Bool {
            return lhs.id == rhs.id
        }
    
}
/**
 Golden Lines took 2 hrs of debugging:
 "Always remember: If you dont make nullable fields optional, you will get an error"
 */

// MARK: - Album
struct Tracks: Decodable {
    let href: String
    let limit: Int
    let next: String? // Nullable field
    let offset: Int
    let previous: String? // Nullable field
    let total: Int
    let items: [Track]
}

