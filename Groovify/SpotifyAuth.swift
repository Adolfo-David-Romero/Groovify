//
//  SpotifyAuthManager.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-11-03.
//

import Foundation

class SpotifyAuth {
    
    /*
         Login at Spotify Developers website:
            -> visit Dashboard
            -> create Application
            -> Under application you can find these fields.
     */
    
    // TODO: Add these clientId, clientSecret and tokenURL as environment variable instead of using constants.
    private let clientId = "6954911535bf4ded95f66f8cc0f72db6"
    private let clientSecret = "def5e9d9134f4f15900a02204162171c"
    private let tokenURL = "https://accounts.spotify.com/api/token"
    var accessToken: String?

    func authenticate(completion: @escaping (Result<String, Error>) -> Void) {
        /**
            Function to authenticate user and setup the accessToken which is required to make API calls to spotify's platform.
         - returns: accessToken is returned on completion.
         */
        guard let url = URL(string: tokenURL) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let authString = "\(clientId):\(clientSecret)"
            .data(using: .utf8)?
            .base64EncodedString() ?? ""
        request.setValue("Basic \(authString)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let token = json["access_token"] as? String {
                    self.accessToken = token
                    completion(.success(token))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

