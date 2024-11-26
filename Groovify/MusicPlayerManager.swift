//
//  MusicPlayerManager.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-11-26.
//

import Foundation
import AVKit

class MusicPlayerManager: ObservableObject{
    
    static let shared = MusicPlayerManager()
    
    @Published var currentTrack: (any TrackDisplayable)? = nil
    @Published var isPlaying: Bool = false
    @Published private var player: AVPlayer?

    
    private init() {}
    
    
    func play(track: any TrackDisplayable) {
            currentTrack = track
            isPlaying = true
        guard let previewURL = track.previewURL else {
            return}
            player = AVPlayer(url: previewURL)
            player?.play()
        }
        
    func pause() {
            isPlaying = false
            player?.pause()
    }
        
    func next() {
            // Placeholder for next track logic
    }
        
    func previous() {
            // Placeholder for previous track logic
    }

}
