//
//  EventViewModel.swift
//  Groovify
//
//  Created by David Romero on 2024-12-11.
//
import Foundation

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var isLoading = true
    @Published var errorMessage: String?

    private let locationManager = LocationManager()
    private var notifiedConcerts: Set<String> = [] // To track already notified concerts

    init() {
        fetchEvents()
        NotificationManager.shared.requestPermission() // Request notification permissions on init
    }

    func fetchEvents() {
        print("Fetching events...")

        guard let userLocation = locationManager.userLocation else {
            DispatchQueue.main.async {
                self.errorMessage = "Unable to fetch user location."
                self.isLoading = false
            }
            print("User location unavailable")
            return
        }

        // Clear previous errors
        self.errorMessage = nil

        let latitude = userLocation.latitude
        let longitude = userLocation.longitude
        let url = "https://app.ticketmaster.com/discovery/v2/events.json?classificationName=music&latlong=\(latitude),\(longitude)&radius=25&unit=miles&size=5&apikey=Gi1OvzsbJnIfUCmuJchFVUIU7Cb2FaXY"
        print("Request URL: \(url)")

        fetchMusicEvents(latitude: latitude, longitude: longitude) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedEvents):
                    print("Fetched \(fetchedEvents.count) events")
                    self.events = fetchedEvents
                    self.isLoading = false
                    self.errorMessage = nil
                    self.notifyNewConcerts(fetchedEvents) // Notify new concerts
                case .failure(let error):
                    print("Error fetching events: \(error.localizedDescription)")
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }

    /// Notify user of new concerts
    private func notifyNewConcerts(_ concerts: [Event]) {
        for concert in concerts {
            let identifier = "\(concert.name)_\(concert.dates.start.localDate)".replacingOccurrences(of: " ", with: "_")
            if !notifiedConcerts.contains(identifier) {
                notifiedConcerts.insert(identifier)
                NotificationManager.shared.scheduleNotification(
                    for: concert.name,
                    date: concert.dates.start.localDate,
                    venue: concert.venueName
                )
            }
        }
    }

    func retryFetchingEvents() {
        isLoading = true
        errorMessage = nil
        fetchEvents()
    }
}
