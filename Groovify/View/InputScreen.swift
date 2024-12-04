//
//  InputScreen.swift
//  Groovify
//
//  Created by Iman on 2024-11-07.
//

import SwiftUI
import FirebaseVertexAI

// Initialize the Vertex AI service
let vertex = VertexAI.vertexAI()

// Initialize the generative model with a model that supports your use case
// Gemini 1.5 models are versatile and can be used with all API capabilities
let model = vertex.generativeModel(modelName: "gemini-1.5-flash")

struct InputScreen: View {
    @State private var searchText = ""
    @State private var selectedEmotions = Set<String>()
    @State private var searchMode: SearchMode = .emotionBased // To toggle between modes
    @State private var searchQuery = ""
    @State private var tracks: [Track] = []
    @State private var errorMessage: String?
    @State private var selectedTrack: Track?
    @Environment(\.spotifyAPI) private var api

    enum SearchMode: String, CaseIterable {
        case emotionBased = "Emotion Search"
        case normalSearch = "Normal Search"
    }
    private func search() {
        api.searchTracks(query: searchQuery) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let tracks):
                    self.tracks = tracks
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func test() async {
        let url = URL(string: "https://api-inference.huggingface.co/models/bigscience/bloom")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer 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", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["inputs": "What is 1 + 2?"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        print(request.allHTTPHeaderFields) // Log request headers

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print("Hello")
            print("Response data: \(data)")
            // print raw data
            if let rawResponse = String(data: data, encoding: .utf8) {
                print("Raw response: \(rawResponse)")
            }
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                print("JSON Response: \(json)")
            }
        } catch {
            print("Error: \(error)")
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
            .background(Color(red: 10.0/255.0, green: 14.0/255.0, blue: 69.0/255.0))
        }
    }

    var emotionSearchView: some View {
        VStack {
            Text("Emotions")
                .foregroundColor(.white)

            // Search bar
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
                            print("Selected emotions: \(selectedEmotions)")
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

            NavigationLink(destination: OutputScreen(initialSearchText: searchText)) {
                Text("See Results")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .font(.system(size: 18))
            }
            Button("Test") {
                Task{
                    await test()}
            }
        }
    }

// Add a normal search view,
// TODO: Separate this into a separate view later
    var normalSearchView: some View {
        VStack {
            Text("Normal Search")
                .foregroundColor(.white)
                .padding(.top)

            HStack {
                TextField("Search tracks...", text: $searchQuery, onCommit: search)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: searchQuery) {
                        search()
                    }
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
    InputScreen()
}
