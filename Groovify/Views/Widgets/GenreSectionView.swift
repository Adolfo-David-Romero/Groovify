//
//  GenreSectionView.swift
//  Groovify
//
//  Created by Iman on 2024-12-10.
//

import SwiftUI

struct GenreSectionView:  View {
    var title: String // Title of the section
    var genres: [String] // Genres to display in the section
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            // Title on top of the section
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal)
                .foregroundColor(.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(genres, id: \.self) { genre in
                        VStack(alignment: .leading)  {
                            //                            Rectangle()
                            //                                .fill(homeViewModel.randomColor())
                            //                                .frame(width: 120, height: 120)
                            //                                .cornerRadius(10)
                            //                            Text(genre)
                            //                                .font(.caption)
                            //                                .lineLimit(1)
                            //                                .frame(width: 150)
                            //                                .foregroundColor(.primary)
                            ZStack {
                                Rectangle()
                                    .fill(homeViewModel.randomColor())
                                    .frame(width: 120, height: 120)
                                    .cornerRadius(10)
                                
                                HStack {
                                    Image(systemName: "music.note") // Replace with your desired icon
                                        .foregroundColor(.white)
                                        .font(.title2)
                                    
                                    Text(genre)
                                        .font(.caption)
                                        .foregroundColor(.white)
                                }
                                .padding()
                            }
                            
                        }
                    }
                    
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    GenreSectionView(title: "Genres", genres: ["Pop", "Rap", "Alternative", "Funk", "Classical"])
}


