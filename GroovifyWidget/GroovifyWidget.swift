//
//  GroovifyWidget.swift
//  GroovifyWidget
//
//  Created by Iman on 2024-12-10.
//

import WidgetKit
import SwiftUI

// Model for the timeline entry
struct TrackEntry: TimelineEntry {
    let date: Date
    let track: String
    let imageUrl: String?
}

// SwiftUI view for displaying the widget content
//struct GroovifyWidgetEntryView: View {
//    var entry: TrackEntry
//
//    var body: some View {
//        ZStack {
//            Color(red: 10.0 / 255.0, green: 14.0 / 255.0, blue: 69.0 / 255.0)
//                .ignoresSafeArea()
//
//            VStack(alignment: .leading, spacing: 8) {
//                HStack{
//                    Image(systemName: "music.note")
//                        .foregroundColor(.blue)
//                        .font(.title2)
//
//
//                    Text("Now Playing")
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                }
//
//
//                HStack(spacing: 10) {
//                    // Image rendering logic similar to PlaylistCarouselView
//                    VStack{
//                        if let imageUrl = entry.imageUrl {
//                            AsyncImage(url: URL(string: imageUrl)) { image in
//                                image
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                            } placeholder: {
//                                Rectangle()
//                                    .foregroundColor(.gray)
//                            }
//                            .frame(width: 100, height: 100) // Adjusted size for widget
//                            .cornerRadius(8)
//                        }
//                    }
//                    Text(entry.track)
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .lineLimit(1)
//                        .minimumScaleFactor(0.8)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                }
//
//
//
//
//            }
//            .padding()
//        }
//        .cornerRadius(15)
//    }
//}
///

struct GroovifyWidgetEntryView: View {
    var entry: TrackEntry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        ZStack {
            Color(red: 10.0 / 255.0, green: 14.0 / 255.0, blue: 69.0 / 255.0)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: spacing) {
                HStack {
                    Image("groovify_icon")
                        .resizable()
                           .scaledToFit()
                           .frame(width: 20, height: 20)
                           .padding(8)
                    
                    Text("Now Playing")
                        .font(headerFont)
                        .foregroundColor(.gray)
                }
                
                HStack(spacing: 10) {
//                    if let imageUrl = entry.imageUrl {
//                        AsyncImage(url: URL(string: imageUrl)) { image in
//                            image
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                        } placeholder: {
//                            Rectangle()
//                                .foregroundColor(.gray)
//                        }
//                        .frame(width: imageSize, height: imageSize)
//                        .cornerRadius(8)
//                    }
                    if let iconURL = entry.imageUrl,
                       let url = URL(string: iconURL),
                       let data = try? Data(contentsOf: url),
                       let image = UIImage(data: data) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    
                    Text(entry.track)
                        .font(.headline)
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
//                Text("url: \(entry.imageUrl)")
//                    .foregroundColor(.white)
                
            }
            .padding(padding)
        }
        .cornerRadius(15)
    }
    
    // Compute dynamic sizes based on widget family
    private var imageSize: CGFloat {
        switch family {
        case .systemSmall:
            return 50
        case .systemMedium:
            return 75
        case .systemLarge:
            return 100
        @unknown default:
            return 50
        }
    }
    
    private var imageFont: Font {
        switch family {
        case .systemSmall:
            return .caption
        case .systemMedium:
            return .title3
        case .systemLarge:
            return .title2
        @unknown default:
            return .caption
        }
    }
    
    private var headerFont: Font {
        switch family {
        case .systemSmall:
            return .caption2
        case .systemMedium:
            return .caption
        case .systemLarge:
            return .subheadline
        @unknown default:
            return .caption2
        }
    }
    
    private var spacing: CGFloat {
        switch family {
        case .systemSmall:
            return 4
        case .systemMedium:
            return 6
        case .systemLarge:
            return 8
        @unknown default:
            return 4
        }
    }
    
    private var padding: EdgeInsets {
        switch family {
        case .systemSmall:
            return EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        case .systemMedium:
            return EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        case .systemLarge:
            return EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        @unknown default:
            return EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        }
    }
}


///


// Timeline provider to fetch and update data
//struct TrackProvider: TimelineProvider {
//    var homeViewModel = HomeViewModel(api: SpotifyAPI.shared)
//
//    func placeholder(in context: Context) -> TrackEntry {
//        TrackEntry(date: Date(), track: "Loading...")
//    }
//
//    func getSnapshot(in context: Context, completion: @escaping (TrackEntry) -> Void) {
//        // Call fetch method synchronously for snapshot
//        homeViewModel.authenticateAndFetchData()
//        let trackName = homeViewModel.newReleases.first?.name ?? "Sample Track"
//        completion(TrackEntry(date: Date(), track: trackName))
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<TrackEntry>) -> Void) {
//        homeViewModel.authenticateAndFetchData()
//
//        guard !homeViewModel.newReleases.isEmpty else {
//            let placeholderEntry = TrackEntry(date: Date(), track: "No Tracks Available")
//            let timeline = Timeline(entries: [placeholderEntry], policy: .atEnd)
//            completion(timeline)
//            return
//        }
//
//        var entries: [TrackEntry] = []
//        let currentDate = Date()
//
//        // Generate entries for the next 5 minutes
//        for minuteOffset in 0..<5 {
//            guard let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate) else { continue }
//            let trackName = homeViewModel.newReleases[minuteOffset % homeViewModel.newReleases.count].name
//            entries.append(TrackEntry(date: entryDate, track: trackName))
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
//}

//claude

// Timeline provider to fetch and update data
struct TrackProvider: TimelineProvider {
    var homeViewModel = HomeViewModel(api: SpotifyAPI.shared)
    
    func placeholder(in context: Context) -> TrackEntry {
        TrackEntry(date: Date(), track: "Loading...", imageUrl: nil)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (TrackEntry) -> Void) {
        homeViewModel.authenticateAndFetchData()
        
        if let firstTrack = homeViewModel.newReleases.first {
            let trackName = firstTrack.name
            let imageUrl = firstTrack.images.first?.url // Assuming images is an array with a url property
            completion(TrackEntry(date: Date(), track: trackName, imageUrl: imageUrl))
        } else {
            completion(TrackEntry(date: Date(), track: "Sample Track", imageUrl: nil))
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<TrackEntry>) -> Void) {
        homeViewModel.authenticateAndFetchData()
        
        guard !homeViewModel.newReleases.isEmpty else {
            let placeholderEntry = TrackEntry(date: Date(), track: "No Tracks Available", imageUrl: nil)
            let timeline = Timeline(entries: [placeholderEntry], policy: .atEnd)
            completion(timeline)
            return
        }
        
        var entries: [TrackEntry] = []
        let currentDate = Date()
        
        // Generate entries for the next 5 minutes
        for minuteOffset in 0..<5 {
            guard let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate) else { continue }
            
            let track = homeViewModel.newReleases[minuteOffset % homeViewModel.newReleases.count]
            let trackName = track.name
            let imageUrl = track.images.first?.url // Assuming images is an array with a url property
            print(imageUrl)
            
            entries.append(TrackEntry(date: entryDate, track: trackName, imageUrl: imageUrl))
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

// Widget configuration
struct GroovifyWidget: Widget {
    let kind: String = "GroovifyWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TrackProvider()) { entry in
            GroovifyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Groovify")
        .description("Displays your recent tracks.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

//// Preview for the widget
//struct GroovifyWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        GroovifyWidgetEntryView(entry: TrackEntry(date: Date(), track: "Sample Track"))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}




// Preview for the widget
//struct GroovifyWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        GroovifyWidgetEntryView(entry: TrackEntry(
//            date: Date(),
//            track: "Sample Track",
//            imageUrl: "https://example.com/sample-image.jpg"
//        ))
//        .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
