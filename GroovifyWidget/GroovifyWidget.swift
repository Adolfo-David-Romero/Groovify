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
}

// SwiftUI view for displaying the widget content
struct GroovifyWidgetEntryView: View {
    var entry: TrackEntry

    var body: some View {
        ZStack {
            Color(red: 10.0 / 255.0, green: 14.0 / 255.0, blue: 69.0 / 255.0)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 8) {
                Text("Now Playing")
                    .font(.caption)
                    .foregroundColor(.gray)

                Text(entry.track)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .padding()
        }
        .cornerRadius(15)
    }
}

// Timeline provider to fetch and update data
struct TrackProvider: TimelineProvider {
    var homeViewModel = HomeViewModel(api: SpotifyAPI.shared)

    func placeholder(in context: Context) -> TrackEntry {
        TrackEntry(date: Date(), track: "Loading...")
    }

    func getSnapshot(in context: Context, completion: @escaping (TrackEntry) -> Void) {
        // Call fetch method synchronously for snapshot
        homeViewModel.authenticateAndFetchData()
        let trackName = homeViewModel.newReleases.first?.name ?? "Sample Track"
        completion(TrackEntry(date: Date(), track: trackName))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<TrackEntry>) -> Void) {
        homeViewModel.authenticateAndFetchData()

        guard !homeViewModel.newReleases.isEmpty else {
            let placeholderEntry = TrackEntry(date: Date(), track: "No Tracks Available")
            let timeline = Timeline(entries: [placeholderEntry], policy: .atEnd)
            completion(timeline)
            return
        }

        var entries: [TrackEntry] = []
        let currentDate = Date()

        // Generate entries for the next 5 minutes
        for minuteOffset in 0..<5 {
            guard let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate) else { continue }
            let trackName = homeViewModel.newReleases[minuteOffset % homeViewModel.newReleases.count].name
            entries.append(TrackEntry(date: entryDate, track: trackName))
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

// Preview for the widget
struct GroovifyWidget_Previews: PreviewProvider {
    static var previews: some View {
        GroovifyWidgetEntryView(entry: TrackEntry(date: Date(), track: "Sample Track"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
