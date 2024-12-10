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
    //Declared viewmodels
    @StateObject var authViewModel: AuthViewModel
    @StateObject var homeViewModel: HomeViewModel
    
    //Persistence controller
    let persistenceController = PersistenceController.shared
    
    @Environment(\.spotifyAPI) var api
    
    init(){
        //MARK: - Firebase services
        FirebaseApp.configure()
        
        //MARK: - Viewmodels
        
        _authViewModel = StateObject(wrappedValue: AuthViewModel())//Auth
        _homeViewModel = StateObject(wrappedValue: HomeViewModel(api: SpotifyAPI.shared))//Home
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack{
                RootView()
                    .environmentObject(authViewModel)
                    .environmentObject(homeViewModel)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            //            ContentView() // commented out for testing
            //HomeView()
            //InputScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
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
                MainTabView() // Main navigation, insert additonal views in MainTabView()

            } else {
                LoginView()
            }
        
    }
}
#Preview {
    RootView().environmentObject(AuthViewModel()).environmentObject(HomeViewModel(api: SpotifyAPI.shared))
}
