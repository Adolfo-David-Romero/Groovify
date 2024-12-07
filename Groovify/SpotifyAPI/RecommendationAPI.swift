import Foundation

struct RecommendationResponse: Codable {
    let genres: [String]
}

class RecommendationViewModel: ObservableObject {
    @Published var genres: [String] = []
    @Published var errorMessage: String? = nil
    
    func fetchRecommendations(for mood: String) {
        guard let url = URL(string: "https://refactored-chainsaw-v45xprx5g54cwvvp-8000.app.github.dev/recommendation") else {
            errorMessage = "Invalid URL"
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
                }
                return
            }
            
            // Handle HTTP response
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    self?.errorMessage = "Invalid server response"
                }
                return
            }
            
            // Decode JSON response
            if let decodedResponse = try? JSONDecoder().decode(RecommendationResponse.self, from: data) {
                DispatchQueue.main.async {
                    self?.genres = decodedResponse.genres
                    self?.errorMessage = nil
                }
            } else {
                DispatchQueue.main.async {
                    self?.errorMessage = "Failed to decode response"
                }
            }
        }.resume()
    }
}
