//
//  MusicPlayerManager.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-11-26.
//

import Foundation

class MusicPlayerManager: ObservableObject{
    
    static let shared = MusicPlayerManager()
    
    @Published var currentTrack: (any TrackDisplayable)? = nil
    @Published var isPlaying: Bool = false
    
    private init() {}
    
    
    func play(track: any TrackDisplayable) {
            currentTrack = track
            isPlaying = true
        }
        
    func pause() {
            isPlaying = false
    }
        
    func next() {
            // Placeholder for next track logic
    }
        
    func previous() {
            // Placeholder for previous track logic
    }

}
