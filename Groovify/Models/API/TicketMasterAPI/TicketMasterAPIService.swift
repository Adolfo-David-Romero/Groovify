//
//  TicketMasterAPIService.swift
//  Groovify
//
//  Created by David Romero on 2024-12-11.
//

import Foundation
import UIKit
import CoreLocation
import CoreData
import SwiftUI

func fetchMusicEvents(latitude: Double, longitude: Double, completion: @escaping (Result<[Event], Error>) -> Void) {
    let apiKey = "    Gi1OvzsbJnIfUCmuJchFVUIU7Cb2FaXY"
    let urlString = "https://app.ticketmaster.com/discovery/v2/events.json?classificationName=music&latlong=\(latitude),\(longitude)&radius=25&unit=miles&size=5&apikey=\(apiKey)"
    
    guard let url = URL(string: urlString) else {
        print("Invalid URL: \(urlString)")
        completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
        return
    }

    print("Request URL: \(url.absoluteString)")

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Network error: \(error.localizedDescription)")
            completion(.failure(error))
            return
        }

        if let httpResponse = response as? HTTPURLResponse {
            print("HTTP Status Code: \(httpResponse.statusCode)")
            if httpResponse.statusCode != 200 {
                completion(.failure(NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: nil)))
                return
            }
        }

        guard let data = data else {
            print("No data received")
            completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
            return
        }

        do {
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON Response: \(jsonString)")
            }

            let decoder = JSONDecoder()
            let eventResponse = try decoder.decode(EventResponse.self, from: data)
            print("Decoded Events: \(eventResponse.embedded.events.map { $0.name })")
            completion(.success(eventResponse.embedded.events))
        } catch {
            print("Decoding error: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
    task.resume()
}
