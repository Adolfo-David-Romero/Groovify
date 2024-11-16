//
//  NewReleases.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-11-16.
//

import Foundation

struct NewReleasesResponse: Decodable {
    let albums: AlbumResults
}

struct AlbumResults: Decodable {
    let items: [Album]
    // More properties can be added here.
}

struct Album: Decodable, Identifiable {
    let album_type: String
    let id: String
    let name: String
    let images: [AlbumImage]
    let release_date: String
    let href: String
    // More properties can be added here later sirrr:)
}

struct AlbumImage: Decodable {
    let url: String
    let height: Int?
    let width: Int?
}
