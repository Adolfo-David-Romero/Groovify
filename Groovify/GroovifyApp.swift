//
//  GroovifyApp.swift
//  Groovify
//
//  Created by David Romero on 2024-10-30.
//

import SwiftUI
import Firebase
@main
struct GroovifyApp: App {
    @StateObject var authViewModel: AuthViewModel
    let persistenceController = PersistenceController.shared
    //@StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
        
        //Auth View model
        _authViewModel = StateObject(wrappedValue: AuthViewModel())
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack{
//                RootView().environment(\.managedObjectContext, persistenceController.container.viewContext)
//                    .environmentObject(viewModel)
                RootView()
                    .environmentObject(authViewModel)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            //            ContentView() // commented out for testing
            //HomeView()
            // Add the environment object to the view hierarchy, as music player manager is an observable object,
            // and it is used in multiple views.
                .environment(\.spotifyAPI, SpotifyAPI.shared)
                .environmentObject(MusicPlayerManager.shared)
        }
    }
}

//MARK: - Root navigation
struct RootView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
            if viewModel.userSession != nil {
                InputScreen()

            } else {
                LoginView()
            }
        
    }
}
#Preview {
    RootView().environmentObject(AuthViewModel())
}
