//
//  EventView.swift
//  Groovify
//
//  Created by David Romero on 2024-12-11.
//

import SwiftUI


struct EventView: View {
    @StateObject private var viewModel = EventViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Nearby Music Events")
                    .font(.headline)
                Spacer()
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .padding(.horizontal)

            if let errorMessage = viewModel.errorMessage {
                VStack {
                    Text("Error: \(errorMessage)")
                        .font(.subheadline)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                    Button(action: viewModel.retryFetchingEvents) {
                        Text("Retry")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding()
            } else if viewModel.events.isEmpty {
                Text("No events found nearby.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.events, id: \.name) { event in
                            VStack(alignment: .leading) {
                                Text(event.name.isEmpty ? "Unknown Event" : event.name)
                                    .font(.headline)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                Text(event.venueName.isEmpty ? "Unknown Venue" : event.venueName)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text(event.dates.start.localDate.isEmpty ? "Unknown Date" : event.dates.start.localDate)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            Divider()
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.systemGray6))
        )
        .padding()
        .frame(width: 300) // Adjusted width for smaller rectangle
    }
}


#Preview {
    EventView()
}
