import SwiftUI

struct RecommendationResponse: Codable {
    let genres: [String]
}

class RecommendationViewModel: ObservableObject {
    @Published var genres: [String] = []
    @Published var errorMessage: String? = nil
    
    func fetchRecommendations(for mood: String, completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: "http://34.47.47.161:8000/recommendation") else {
            errorMessage = "Invalid URL"
            completion(.failure(NSError(domain: "NetworkError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: String] = ["mood": mood]
        request.httpBody = try? JSONEncoder().encode(requestBody)
        
        // Perform network request
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            // Handle errors
            if let error = error {
                DispatchQueue.main.async {
                    self?.errorMessage = "Error: \(error.localizedDescription)"
                    completion(.failure(error))
                }
                return
            }
            
            // Handle HTTP response
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                let error = NSError(domain: "NetworkError", code: -2, userInfo: [NSLocalizedDescriptionKey: "Invalid server response"])
                DispatchQueue.main.async {
                    self?.errorMessage = "Invalid server response"
                    completion(.failure(error))
                }
                return
            }
            
            // Decode JSON response
            do {
                let decodedResponse = try JSONDecoder().decode(RecommendationResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.genres = decodedResponse.genres
                    self?.errorMessage = nil
                    completion(.success(decodedResponse.genres))
                }
            } catch {
                DispatchQueue.main.async {
                    self?.errorMessage = "Failed to decode response"
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
