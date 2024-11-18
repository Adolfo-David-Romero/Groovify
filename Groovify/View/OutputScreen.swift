//
//  OutputScreen.swift
//  Groovify
//
//  Created by Iman on 2024-11-07.
//

import SwiftUI

struct OutputScreen: View {
    var initialSearchText : String
    @State private var searchText = ""
    let personalizedMessage = "Here are 10 songs for you to groove along to: I hope these songs bring you even more happiness to your day!" //TODO: ai generate
        let songTitles = ["Song 1", "Song 2", "Song 3", "Song 4"] // Add more song titles

    
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Groovify Song List:")
                    .foregroundColor(.white)
            
                
                // Search bar
                HStack {
//                    TextField("🤩 How are you feeling today?", text: $searchText)
//                        .textFieldStyle(.roundedBorder)
                    TextField("You entered: \(initialSearchText)", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.horizontal)
                
                
             HStack{
                 Text("GROOVIFY")
                 .font(.largeTitle.bold())
                 .foregroundColor(.white)
                 
                 Spacer()
                 
                 Image("groovify_icon")
                     .resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(height: 50)
                     

             }.padding()
                
                Text(personalizedMessage)
                .font(.headline)
                .padding(.bottom, 20)
                .foregroundColor(.white)
                
                // Song List
                List(songTitles, id: \.self) { songTitle in
                    Text(songTitle)
                        .font(.headline)
                }
                .listStyle(.plain)
                .background(Color(red: 205.0/255.0, green: 204.0/255.0, blue: 220.0/255.0))
                .cornerRadius(10)
                
            }
            .padding()
            .background(Color(red: 10.0/255.0, green: 14.0/255.0, blue: 69.0/255.0))
        }
    }
}

#Preview {
    OutputScreen(initialSearchText: "Today I feel happy and energetic!")
}
