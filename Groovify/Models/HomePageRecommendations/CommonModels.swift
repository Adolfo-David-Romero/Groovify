//
//  CommonModels.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-11-16.
//

import Foundation

// MARK: - CarouselItem (Protocol to display carousel items)
protocol CarouselItem: Identifiable {
    var name: String { get }
    var images: [SpotifyImage] { get }
}


// MARK: - SimplifiedArtist
struct SimplifiedArtist: Decodable, Identifiable {
    let id: String
    let name: String
    let href: String
}

// MARK: - Track
struct Track: Decodable, Identifiable {
    let id: String
    let name: String
    let album: Album?
    let artists: [SimplifiedArtist]
    let popularity: Int? // Nullable field
    let preview_url: String? // Nullable field
}

// MARK: - SpotifyImage
struct SpotifyImage: Decodable {
    let url: String
    let height: Int?
    let width: Int?
}

// MARK: - TrackDisplayable (Protocol to display track data)
protocol TrackDisplayable: Identifiable {
    var name: String { get }
    var artistNames: String { get }
    var previewURL: URL? { get }
    var album: Album? { get }
}

// Extension to conform Track to TrackDisplayable
extension Track: TrackDisplayable {
    var artistNames: String {
        artists.map { $0.name }.joined(separator: ", ")
    }
    var previewURL: URL? {
        URL(string: preview_url ?? "")
    }
}

// Extension to conform TrackOrEpisode to TrackDisplayable
extension TrackOrEpisode: TrackDisplayable {
    var id: String {
        switch self {
        case .track(let track): return track.id
        case .episode(let episode): return episode.id
        }
    }

    var name: String {
        switch self {
        case .track(let track): return track.name
        case .episode(let episode): return episode.name
        }
    }

    var artistNames: String {
        switch self {
        case .track(let track): return track.artists.map { $0.name }.joined(separator: ", ")
        case .episode: return "Episode"
        }
    }

    var previewURL: URL? {
        switch self {
        case .track(let track): return URL(string: track.preview_url ?? "")
        case .episode: return nil
        }
    }
    var album: Album? {
        switch self {
            case .track(let track): return track.album
            case .episode: return nil
        }
    }
}
