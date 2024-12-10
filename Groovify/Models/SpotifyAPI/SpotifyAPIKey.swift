//
//  SpotifyAPIKey.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-12-03.
//

import SwiftUI

struct SpotifyAPIKey: EnvironmentKey {
    static let defaultValue = SpotifyAPI.shared // Default to the singleton instance
}

extension EnvironmentValues {
    var spotifyAPI: SpotifyAPI {
        get { self[SpotifyAPIKey.self] }
        set { self[SpotifyAPIKey.self] = newValue }
    }
}
