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
    let href: String
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

struct PlaylistTrackResponse: Decodable{
    let items: [PlaylistTrackObject]
}

// MARK: - PlaylistTrackObject
struct PlaylistTrackObject: Decodable{
    let added_at: String?
    let added_by: SpotifyUser?
    let is_local: Bool
    let track: TrackOrEpisode
}

// MARK: - SpotifyUser
struct SpotifyUser: Decodable {
    let id: String
    let href: String
    let external_urls: [String: String]
}

// MARK: - TrackOrEpisode (Polymorphic Type)
enum TrackOrEpisode: Decodable {
    case track(TrackObject)
    case episode(EpisodeObject)

    // Decode based on the presence of "type" field
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case "track":
            self = .track(try TrackObject(from: decoder))
        case "episode":
            self = .episode(try EpisodeObject(from: decoder))
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Invalid type value")
        }
    }

    private enum CodingKeys: String, CodingKey {
        case type
    }
}

// MARK: - TrackObject
struct TrackObject: Decodable, Identifiable {
    let id: String
    let name: String
    let album: Album
    let artists: [SimplifiedArtist]
    let duration_ms: Int
    let explicit: Bool
    let href: String
    let preview_url: String?
    let track_number: Int
    let popularity: Int
    let uri: String
}

// MARK: - EpisodeObject
struct EpisodeObject: Decodable, Identifiable {
    let id: String
    let name: String
    let description: String
    let htmlDescription: String
    let duration_ms: Int
    let explicit: Bool
    let href: String
    let images: [SpotifyImage]
    let isExternallyHosted: Bool
    let isPlayable: Bool
    let languages: [String]
    let releaseDate: String
    let releaseDatePrecision: String
    let uri: String
}

// MARK: - Album
struct Album: Decodable, Identifiable {
    let id: String
    let name: String
    let href: String
    let images: [SpotifyImage]
}

// MARK: - SimplifiedArtist
struct SimplifiedArtist: Decodable, Identifiable {
    let id: String
    let name: String
    let href: String
}

