//
//  HomeView.swift
//  Groovify
//
//  Created by Kunal on 2024-11-11.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack{
            TopBarView()
            ScrollView{
                
                ListView(title: "Your Recent Tracks", tracks: ["Song1", "Song2", "Song3", "Song4", "Song5"])
                SectionView(title: "Top Charts", items: ["Song1", "Song2", "Song3", "Song4", "Song5"])
                SectionView(title: "Featured Playlists", items: ["Song1", "Song2", "Song3", "Song4", "Song5"])
                SectionView(title: "New Releases", items: ["Song1", "Song2", "Song3", "Song4", "Song5"])
                SectionView(title: "Genres", items: ["Pop", "Rock", "Hip-Hop", "Jazz", "Classical"])
                
            }
            MiniPlayerView(track: "Song1")
        }
    }
}

#Preview {
    HomeView()
}
