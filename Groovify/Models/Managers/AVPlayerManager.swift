////
////  AVPlayerManager.swift
////  Groovify
////
////  Created by Kunal Bajaj on 2024-11-26.
////
//
//import Foundation
//import AVKit
//
//class AVPlayerManager: ObservableObject {
//    static let shared = AVPlayerManager()
//    
//    private var player: AVPlayer?
//    @Published var isPlaying: Bool = false
//    
//    private init() { }
//    
//    func play(track: any TrackDisplayable) {
//        guard let previewURL = track.previewURL else { return }
//        
//        if player == nil {
//            player = AVPlayer(url: previewURL)
//        }
//        
//        if isPlaying {
//            pause()
//        } else {
//            player?.play()
//        }
//        
//        isPlaying.toggle()
//    }
//    
//    func pause() {
//        player?.pause()
//        isPlaying = false
//    }
//    
//    func stop() {
//        player?.pause()
//        player = nil
//        isPlaying = false
//    }
//    
//    func getPlayer() -> AVPlayer? {
//        return player
//    }
//}
