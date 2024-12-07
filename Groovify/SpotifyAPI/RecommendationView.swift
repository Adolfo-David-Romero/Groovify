import SwiftUI

// Test view for api testing
struct RecommendationView: View {
    @StateObject private var viewModel = RecommendationViewModel()
    @State private var mood: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter your mood", text: $mood)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Get Recommendations") {
                viewModel.fetchRecommendations(for: mood)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            } else {
                List(viewModel.genres, id: \.self) { genre in
                    Text(genre)
                }
            }
        }
        .padding()
    }
}
