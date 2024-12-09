//
//  MusicPlayerManager.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-11-26.
//

import Foundation
import AVKit

// MARK: - MusicPlayerManager (Class to manage music player)
class MusicPlayerManager: ObservableObject{
    
    // Singleton instance
    static let shared = MusicPlayerManager()
    
    //MARK: - Properties
    /*
        currentTrack: The track that is currently being played
        isPlaying: A boolean value to indicate whether the track is currently playing
        player: An instance of AVPlayer to play the track
     */
    @Published var currentTrack: (any TrackDisplayable)? = nil
    @Published var isPlaying: Bool = false
    @Published private var player: AVPlayer?

    
    private init() {}
    
    //MARK: - Methods
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
