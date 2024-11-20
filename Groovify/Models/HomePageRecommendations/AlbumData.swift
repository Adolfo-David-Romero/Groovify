//
//  AlbumData.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-11-17.
//

import Foundation

struct AlbumData: Decodable {
    let album_type: String
    let id: String
    let name: String
    let images: [SpotifyImage]
    let total_tracks: Int
    let artists: [Artist]
    let tracks: Tracks
    
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

struct Track: Decodable, Identifiable {
    let id: String
    let name: String
    let artists: [Artist]
    let popularity: Int? // Nullable field
    let preview_url: String? // Nullable field
}

struct Artist: Decodable {
    let name: String
}
