//
//  CommonModels.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-11-16.
//

import Foundation

protocol CarouselItem: Identifiable {
    var name: String { get }
    var images: [SpotifyImage] { get }
}

protocol TrackViewObject{
    var name: String { get }
    var artists: [SimplifiedArtist] { get }
    var preview_url: String? { get }
    
}

// MARK: - SimplifiedArtist
struct SimplifiedArtist: Decodable, Identifiable {
    let id: String
    let name: String
    let href: String
}

struct Track: Decodable, Identifiable {
    let id: String
    let name: String
    let artists: [SimplifiedArtist]
    let popularity: Int? // Nullable field
    let preview_url: String? // Nullable field
}


struct SpotifyImage: Decodable {
    let url: String
    let height: Int?
    let width: Int?
}
