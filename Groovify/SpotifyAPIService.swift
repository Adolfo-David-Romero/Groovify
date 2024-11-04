//
//  SpotifyAPIService.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-11-03.
//

import Foundation

class SpotifyAPI {
    
    // TODO: Add in environment variables.
    private let baseURL = "https://api.spotify.com/v1"
    public var auth = SpotifyAuth()

    private func makeRequest(endpoint: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        /**
         Abstract function to make requests to the api
            - parameter :  endpoint (to specify which request to make)
            - returns : Data is returned on completion or Error .
         */
        
        // Retrieving access token from SpotifyAuth() object instance.
        guard let accessToken = auth.accessToken else {
            completion(.failure(NSError(domain: "AuthError", code: 401, userInfo: [NSLocalizedDescriptionKey: "No access token"])))
            return
        }
        // creating url from endpoint, specifying api call.
        guard let url = URL(string: "\(baseURL)\(endpoint)") else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            completion(.success(data))
        }.resume()
    }

    
}
