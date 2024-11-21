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
        print("Making request to \(url)")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            print("Data received")
            completion(.success(data))
        }.resume()
    }
    func getFeaturedPlaylists(completion: @escaping (Result<[Playlist], Error>) -> Void) {
        let endpoint = "/browse/featured-playlists"
        
        makeRequest(endpoint: endpoint) { result in
            switch result {
                case .success(let data):
                    do {
                        let json = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
                        let playlists = json.playlists.items
                        print(playlists)
                        completion(.success(playlists))
                    }
                    catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    func getNewReleases(completion: @escaping (Result<[NewRelease], Error>) -> Void) {
        let endpoint = "/browse/new-releases"
        
        makeRequest(endpoint: endpoint){ result in
            switch result{
                case.success(let data):
                    print(data, "Data")
                    do{
                        let json = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                        let albums = json.albums.items
                        completion(.success(albums))
                    }
                    catch{
                        completion(.failure(error))
                    }
                case.failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getAlbumData(endpoint: String, completion: @escaping (Result<AlbumData, Error>) -> Void) {
        print("Getting album data for \(endpoint)")
        makeRequest(endpoint: endpoint) { result in
            print(result, "Result")
            switch result {
                case .success(let data):
                    do {
                        let albumData = try JSONDecoder().decode(AlbumData.self, from: data)
                        print(albumData, "Album Data")
                        print("Hello")
                        completion(.success(albumData)) // Return album data on success.
                    } catch {
                        completion(.failure(error))}
                case.failure(let error):
                    print("Error")
                    completion(.failure(error))
            }
        }
    }
    
    func getPlaylistTracks(endpoint: String, completion: @escaping (Result<[PlaylistTrackObject], Error>) -> Void) {
        print("Getting playlist tracks for \(endpoint)")
        makeRequest(endpoint: endpoint) { result in
            switch result {
                case .success(let data):
                    do {
                        
                        /**
                         Golden Lines for debugging
                         */
                        //Print raw JSON for debugging
//                        if let jsonString = String(data: data, encoding: .utf8) {
//                            print("Raw JSON response: \(jsonString)")
//                        }
                        
                        let playlistData = try JSONDecoder().decode(PlaylistTrackResponse.self, from: data).items
                        
                        print("Playlist data: \(playlistData)")
                        completion(.success(playlistData))
                    }
                    /**
                     Golden Lines for debugging, finally understood value of error handling
                     */
                    catch {
                        print("Decoding error: \(error)")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("Network error: \(error)")
                    completion(.failure(error))
            }
        }
    }
    
}
                        
