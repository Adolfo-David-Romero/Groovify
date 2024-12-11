//
//  GroovifyWidget.swift
//  GroovifyWidget
//
//  Created by Iman on 2024-12-10.
//

import WidgetKit
import SwiftUI

//model

struct TrackEntry: TimelineEntry {
    let date: Date
    let track: String
}

//swift ui view

struct GroovifyWidgetEntryView : View {
  
    var homeViewModel = HomeViewModel(api: SpotifyAPI.shared)
    
    var entry: TrackEntry

    var body: some View {
        ZStack{
            Color(red: 10.0 / 255.0, green: 14.0 / 255.0, blue: 69.0 / 255.0)
            VStack {
                // Recent Tracks
                ListView(title: "Your Recent Tracks", tracks: Array(homeViewModel.newReleases.shuffled().prefix(5)))
            }
            .padding()
        }
       // .background(Color(red: 10.0 / 255.0, green: 14.0 / 255.0, blue: 69.0 / 255.0))
        .cornerRadius(20)
    }
}


//test ui
//struct GroovifyWidgetEntryView: View {
//    var entry: TrackEntry
//
//    var body: some View {
//        
//        ZStack{
//            Color(red: 10.0 / 255.0, green: 14.0 / 255.0, blue: 69.0 / 255.0)
//            VStack(alignment: .leading) {
//                Text("Recent Tracks")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//                    .padding(.horizontal)
//
//                Text(entry.track)
//                    .foregroundColor(.white)
//                    .padding(.horizontal)
//            }
//            .padding()
//        }
//        
//       // .background(Color(red: 10.0 / 255.0, green: 14.0 / 255.0, blue: 69.0 / 255.0))
//        .cornerRadius(20)
//    }
//}
//timeline provider

struct TrackProvider  : TimelineProvider {
    var homeViewModel = HomeViewModel(api: SpotifyAPI.shared)
    
    func placeholder(in context: Context) -> TrackEntry {
        
        TrackEntry(date: Date(), track: "Song 1")
        }
    
    
    func getSnapshot(in context: Context, completion: @escaping (TrackEntry) -> Void) {
        
        completion(TrackEntry(date: Date(), track: "Song 2"))
    }
    
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<TrackEntry>) -> Void) {
        
        var entries : [TrackEntry] = []
        
        
        for minuteOffset in 0..<1 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: Date())
            let entry = TrackEntry(date: entryDate!, track: homeViewModel.newReleases.randomElement()?.name ?? "No Songs")
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
// Timeline Provider

//struct TrackProvider: TimelineProvider {
//    
//    // Dummy data (replace with actual API calls in a real scenario)
//    let dummyTracks = ["Song 1", "Song 2", "Song 3", "Song 4", "Song 5"]
//
//    func placeholder(in context: Context) -> TrackEntry {
//        TrackEntry(date: Date(), track: "Song 1")
//    }
//
//    func getSnapshot(in context: Context, completion: @escaping (TrackEntry) -> Void) {
//        completion(TrackEntry(date: Date(), track: "Song 2"))
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<TrackEntry>) -> Void) {
//        var entries: [TrackEntry] = []
//
//        for minuteOffset in 0..<1 {
//            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: Date())!
//            let randomIndex = Int.random(in: 0..<dummyTracks.count)
//            let track = dummyTracks[randomIndex]
//            let entry = TrackEntry(date: entryDate, track: track)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
//}


//configure widget

struct GroovifyWidget: Widget {
    let kind = "GroovifyWidget"

    var body : some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TrackProvider()){ entry in
            GroovifyWidgetEntryView(entry:  entry)
        }.configurationDisplayName("Songs")
            .description("Get new song every minute")
            .supportedFamilies([.systemSmall ,.systemMedium ,.systemLarge])
        
        
    }
}


//#Preview(as: .systemSmall) {
//  GroovifyWidget()
//    .timeline(
//      entries: [
//        TrackEntry(date: Date(), track: "Song 1"),
//        TrackEntry(date: Date().addingTimeInterval(60), track: "Song 2") // Simulate future entry
//      ],
//      policy: .atEnd
//    )
//}
