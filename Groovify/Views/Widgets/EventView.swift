//
//  EventView.swift
//  Groovify
//
//  Created by David Romero on 2024-12-11.
//

import SwiftUI


struct EventView: View {
    @ObservedObject var locationManager = LocationManager()
    @State private var events: [Event] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Nearby Music Events")
                    .font(.headline)
                    .padding(.horizontal)

                if let locationError = locationManager.locationError {
                    VStack {
                        Text(locationError)
                            .foregroundColor(.red)
                            .padding()
                        Button(action: retryFetchingEvents) {
                            Text("Retry")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                    }
                } else if isLoading {
                    ProgressView("Loading events...")
                        .padding()
                } else if let errorMessage = errorMessage {
                    VStack {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                            .padding()
                        Button(action: retryFetchingEvents) {
                            Text("Retry")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                    }
                } else if events.isEmpty {
                    Text("No events found nearby.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(events, id: \.name) { event in
                                VStack(alignment: .leading) {
                                    Text(event.name.isEmpty ? "Unknown Event" : event.name)
                                        .font(.headline)
                                    Text(event.venueName.isEmpty ? "Unknown Venue" : event.venueName)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Text(event.dates.start.localDate.isEmpty ? "Unknown Date" : event.dates.start.localDate)
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                Divider()
                            }
                        }
                    }
                    .refreshable {
                        fetchEvents()
                    }
                }
            }
            .onAppear(perform: fetchEvents)
            .navigationBarTitle("Events", displayMode: .inline)
            .frame(maxWidth: .infinity)
            .padding()
        }
    }

    func fetchEvents() {
        print("Fetching events...")

        guard let userLocation = locationManager.userLocation else {
            errorMessage = "Unable to fetch user location."
            print("User location unavailable")
            isLoading = false
            return
        }

        // Clear location error since we have a valid location
        locationManager.locationError = nil
        print("User Location: \(userLocation.latitude), \(userLocation.longitude)")

        let url = "https://app.ticketmaster.com/discovery/v2/events.json?classificationName=music&latlong=\(userLocation.latitude),\(userLocation.longitude)&radius=25&unit=miles&size=5&apikey=Gi1OvzsbJnIfUCmuJchFVUIU7Cb2FaXY"
        print("Request URL: \(url)")

        fetchMusicEvents(latitude: userLocation.latitude, longitude: userLocation.longitude) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedEvents):
                    print("Fetched \(fetchedEvents.count) events")
                    events = fetchedEvents
                    isLoading = false
                    errorMessage = nil  // Clear any lingering API errors
                case .failure(let error):
                    print("Error fetching events: \(error.localizedDescription)")
                    errorMessage = error.localizedDescription
                    isLoading = false
                }
            }
        }
    }


    func retryFetchingEvents() {
        isLoading = true
        errorMessage = nil
        fetchEvents()
    }
}


#Preview {
    EventView()
}
