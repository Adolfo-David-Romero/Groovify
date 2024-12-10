//
//  NewReleases.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-11-16.
//

import Foundation

// For GetNewReleases Endpoint.

// MARK: - NewReleasesResponse
struct NewReleasesResponse: Decodable {
    let albums: AlbumResults
}

// MARK: - AlbumResults
struct AlbumResults: Decodable {
    let items: [NewRelease]
    // More properties can be added here.
}

// MARK: - NewRelease
struct NewRelease: Decodable, Identifiable {
    let album_type: String
    let id: String
    let name: String
    let images: [SpotifyImage]
    let release_date: String
    let href: String
    // More properties can be added here later sirrr:)
}
// Conforming to CarouselItem protocol
extension NewRelease: CarouselItem {}



