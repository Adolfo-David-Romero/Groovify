//
//  AlbumData.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-11-17.
//

import Foundation

struct AlbumData: Decodable, Identifiable, Hashable {
    let album_type: String
    let id: String
    let name: String
    let images: [SpotifyImage]
    let total_tracks: Int
    let artists: [SimplifiedArtist]
    let tracks: Tracks
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        static func == (lhs: AlbumData, rhs: AlbumData) -> Bool {
            return lhs.id == rhs.id
        }
    
}
/**
 
 Always remember: If you dont make nullable fields optional, you will get an error
 */
struct Tracks: Decodable {
    let href: String
    let limit: Int
    let next: String? // Nullable field
    let offset: Int
    let previous: String? // Nullable field
    let total: Int
    let items: [Track]
}

