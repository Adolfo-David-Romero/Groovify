//
//  InputScreen.swift
//  Groovify
//
//  Created by Iman on 2024-11-07.
//
import SwiftUI

struct InputView: View {
    @State private var searchText = ""
    @State private var selectedEmotions = Set<String>()
    @State private var searchMode: SearchMode = .emotionBased
    @State private var searchQuery = ""
    @State private var tracks: [Track] = []
    @State private var errorMessage: String?
    @State private var selectedTrack: Track?
    @State private var isLoading = false
    @StateObject private var recommendationViewModel = RecommendationViewModel()
    @Environment(\.spotifyAPI) private var api
    @State private var navigateToOutput = false // For navigation
    
    enum SearchMode: String, CaseIterable {
        case emotionBased = "Emotion Search"
        case normalSearch = "Normal Search"
    }

    private func processEmotionSearch() {
        guard !selectedEmotions.isEmpty else {
            errorMessage = "Please select at least one emotion"
            return
        }

        isLoading = true
        let mood = selectedEmotions.joined(separator: ", ")

        recommendationViewModel.fetchRecommendations(for: mood) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let genres):
                    searchTracksByGenres(genres)
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }

    private func searchTracksByGenres(_ genres: [String]) {
        let genreQuery = genres.joined(separator: " OR ")
        let searchQuery = "%3Dgenre:\(genreQuery)"

        api.searchTracks(query: searchQuery) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let tracks):
                    self.tracks = tracks
                    navigateToOutput = true // Trigger navigation
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }

    private func search() {
        api.searchTracks(query: searchQuery) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let tracks):
                    self.tracks = tracks
                    navigateToOutput = true // Add navigation trigger
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Search Mode", selection: $searchMode) {
                    ForEach(SearchMode.allCases, id: \.self) { mode in
                        Text(mode.rawValue)
                            .tag(mode)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                if searchMode == .emotionBased {
                    emotionSearchView
                } else {
                    normalSearchView
                }
            }
            .background(Color(red: 10.0 / 255.0, green: 14.0 / 255.0, blue: 69.0 / 255.0))
            .navigationDestination(isPresented: $navigateToOutput) {
                OutputScreen(
                    initialSearchText: searchMode == .emotionBased
                        ? selectedEmotions.joined(separator: ", ")
                        : searchQuery,
                    tracks: tracks
                )
            }
        }
    }

    var emotionSearchView: some View {
        VStack {
            Text("Emotions")
                .foregroundColor(.white)

            HStack {
                TextField("🤩 How are you feeling today?", text: $searchText)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.horizontal)

            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(["Happy", "Nostalgic", "Calm", "Excited", "Romantic", "Sad", "Angry", "Anxious", "Lonely", "Grief", "Jealousy", "Regret"], id: \.self) { emotion in
                        Button(action: {
                            if selectedEmotions.contains(emotion) {
                                selectedEmotions.remove(emotion)
                            } else {
                                selectedEmotions.insert(emotion)
                            }
                        }) {
                            Text("#\(emotion)")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(selectedEmotions.contains(emotion) ? Color.green : Color.purple)
                                .cornerRadius(10)
                                .font(.system(size: 12))
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical)
            }

            Button(action: processEmotionSearch) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("See Results")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .font(.system(size: 18))
                }
            }
            .disabled(selectedEmotions.isEmpty || isLoading)

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear {
            api.auth.authenticate { result in
                if case .failure(let error) = result {
                    errorMessage = error.localizedDescription
                }
            }
        }
    }

    var normalSearchView: some View {
        VStack {
            Text("Normal Search")
                .foregroundColor(.white)
                .padding(.top)

            HStack {
                TextField("Search tracks...", text: $searchQuery, onCommit: search)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.horizontal)

            Button(action: search) {
                Text("Search")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.purple)
                    .cornerRadius(10)
                    .font(.system(size: 18))
            }
            .padding()

            ScrollView {
                TrackListView(tracks: tracks)
            }
        }
        .onAppear {
            api.auth.authenticate { result in
                if case .failure(let error) = result {
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}

#Preview {
    InputView()
}
