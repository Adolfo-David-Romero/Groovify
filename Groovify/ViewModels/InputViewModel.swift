//
//  InputViewModel.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-12-10.
//

import SwiftUI
import Combine

class InputViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var searchText = ""
    @Published var selectedEmotions = Set<String>()
    @Published var searchMode: SearchMode = .emotionBased
    @Published var searchQuery = ""
    @Published var tracks: [Track] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var navigateToOutput = false
    
    // MARK: - Dependencies
    private let spotifyAPI: SpotifyAPI
    private let recommendationViewModel: RecommendationViewModel
    
    // MARK: - Initializer
    init(
        spotifyAPI: SpotifyAPI,
        recommendationViewModel: RecommendationViewModel = RecommendationViewModel()
    ) {
        self.spotifyAPI = spotifyAPI
        self.recommendationViewModel = recommendationViewModel
    }
    
    // MARK: - Emotion Search
    func processEmotionSearch() {
        guard !selectedEmotions.isEmpty else {
            errorMessage = "Please select at least one emotion"
            return
        }

        isLoading = true
        let mood = selectedEmotions.joined(separator: ", ")

        recommendationViewModel.fetchRecommendations(for: mood) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                self.isLoading = false
                switch result {
                case .success(let genres):
                    self.searchTracksByGenres(genres)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // MARK: - Genre Search
    private func searchTracksByGenres(_ genres: [String]) {
        let genreQuery = genres.joined(separator: " OR ")
        let searchQuery = "%3Dgenre:\(genreQuery)"

        spotifyAPI.searchTracks(query: searchQuery) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let tracks):
                    self.tracks = tracks
                    self.navigateToOutput = true
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // MARK: - Normal Search
    func search() {
        spotifyAPI.searchTracks(query: searchQuery) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let tracks):
                    self.tracks = tracks
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // MARK: - Authentication
    func authenticate() {
        spotifyAPI.auth.authenticate { [weak self] result in
            if case .failure(let error) = result {
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // MARK: - Emotion Selection
    func toggleEmotion(_ emotion: String) {
        if selectedEmotions.contains(emotion) {
            selectedEmotions.remove(emotion)
        } else {
            selectedEmotions.insert(emotion)
        }
    }
    
    // MARK: - Emotion List
    let availableEmotions = [
        "Happy", "Nostalgic", "Calm", "Excited", "Romantic",
        "Sad", "Angry", "Anxious", "Lonely", "Grief",
        "Jealousy", "Regret"
    ]
}

// Enum for Search Mode (if not already defined)
enum SearchMode: String, CaseIterable {
    case emotionBased = "Emotion Search"
    case normalSearch = "Normal Search"
}
