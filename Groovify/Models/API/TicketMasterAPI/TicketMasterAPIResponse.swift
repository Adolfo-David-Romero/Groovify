//
//  TicketMasterAPIResponse.swift
//  Groovify
//
//  Created by David Romero on 2024-12-11.
//
import Foundation

import Foundation

struct EventResponse: Codable {
    let embedded: EmbeddedEvents

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}

struct EmbeddedEvents: Codable {
    let events: [Event]
}

struct Event: Codable {
    let name: String
    let dates: EventDates
    let embedded: EmbeddedVenues

    enum CodingKeys: String, CodingKey {
        case name, dates
        case embedded = "_embedded"
    }

    // Computed property for venue name
    var venueName: String {
        embedded.venues.first?.name ?? "Unknown Venue"
    }
}

struct EventDates: Codable {
    let start: EventStart
}

struct EventStart: Codable {
    let localDate: String
}

struct EmbeddedVenues: Codable {
    let venues: [Venue]
}

struct Venue: Codable {
    let name: String?
    let location: VenueLocation?
}

struct VenueLocation: Codable {
    let latitude: String?
    let longitude: String?
}
