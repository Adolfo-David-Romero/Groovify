//
//  InputScreen.swift
//  Groovify
//
//  Created by Iman on 2024-11-07.
//

import SwiftUI

struct InputScreen: View {
    @State private var searchText = ""
    @State private var selectedEmotions = Set<String>()

    var body: some View {
        NavigationStack {
            VStack {
                //
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
                                print("Selected: \(emotion)")
                                    if selectedEmotions.contains(emotion) {
                                           selectedEmotions.remove(emotion)
                                       } else {
                                           selectedEmotions.insert(emotion)
                                       }
                                    // Print the selected emotions
                                    print("\nEmotion in Set:")
                                        for emotion in selectedEmotions {
                                            print(emotion)
                                        }
                                   })
                                {//button content
                                
                                Text("#\(emotion)")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(Color.purple)
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
            }
//            .navigationTitle("Input Screen")
            .background(Color(red: 10.0/255.0, green: 14.0/255.0, blue: 69.0/255.0))
        }
        
    }
}


#Preview {
    InputScreen()
}
