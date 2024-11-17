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
struct Tracks: Decodable {
    let href: String
    let limit: Int
    let next: String
    let offset: Int
    let previous: String
    let total: Int
    let items: [Track]
}

struct Track: Decodable, Identifiable {
    let id: String
    let name: String
    let artists: [Artist]
    let popularity: Int?
    let preview_url: String?
}

struct Artist: Decodable {
    let name: String
}
