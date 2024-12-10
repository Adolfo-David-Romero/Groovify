//
//  InputScreen.swift
//  Groovify
//
//  Created by Iman on 2024-11-07.
//
import SwiftUI

struct InputView: View {
    @StateObject private var viewModel: InputViewModel
    @Environment(\.spotifyAPI) private var api
    
    // Initializer to inject dependencies
    init(
        spotifyAPI: SpotifyAPI? = nil,
        viewModel: InputViewModel? = nil
    ) {
        let spotifyAPIToUse = spotifyAPI ?? SpotifyAPI.shared
        self._viewModel = StateObject(
            wrappedValue: viewModel ?? InputViewModel(spotifyAPI: spotifyAPIToUse)
        )
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Search Mode", selection: $viewModel.searchMode) {
                    ForEach(SearchMode.allCases, id: \.self) { mode in
                        Text(mode.rawValue)
                            .tag(mode)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                if viewModel.searchMode == .emotionBased {
                    emotionSearchView
                } else {
                    normalSearchView
                }
            }
            .background(Color(red: 10.0 / 255.0, green: 14.0 / 255.0, blue: 69.0 / 255.0))
            .navigationDestination(isPresented: $viewModel.navigateToOutput) {
                OutputView(
                    initialSearchText: viewModel.searchMode == .emotionBased
                        ? viewModel.selectedEmotions.joined(separator: ", ")
                        : viewModel.searchQuery,
                    tracks: viewModel.tracks
                )
            }
        }
        .onAppear {
            viewModel.authenticate()
        }
    }

    var emotionSearchView: some View {
        VStack {
            Text("Emotions")
                .foregroundColor(.white)

            HStack {
                TextField("🤩 How are you feeling today?", text: $viewModel.searchText)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.horizontal)

            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(viewModel.availableEmotions, id: \.self) { emotion in
                        Button(action: {
                            viewModel.toggleEmotion(emotion)
                        }) {
                            Text("#\(emotion)")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(viewModel.selectedEmotions.contains(emotion) ? Color.green : Color.purple)
                                .cornerRadius(10)
                                .font(.system(size: 12))
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical)
            }

            Button(action: viewModel.processEmotionSearch) {
                if viewModel.isLoading {
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
            .disabled(viewModel.selectedEmotions.isEmpty || viewModel.isLoading)

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }

    var normalSearchView: some View {
        VStack {
            Text("Normal Search")
                .foregroundColor(.white)
                .padding(.top)

            HStack {
                TextField("Search tracks...", text: $viewModel.searchQuery, onCommit: viewModel.search)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: viewModel.searchQuery) { _ in
                        viewModel.search()
                    }
            }
            .padding(.horizontal)

            Button(action: viewModel.search) {
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
                TrackListView(tracks: viewModel.tracks)
            }
        }
    }
}

#Preview {
    InputView()
}
