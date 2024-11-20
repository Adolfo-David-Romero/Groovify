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
    let persistenceController = PersistenceController.shared
    @StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack{
                RootView().environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}

//MARK: - Root navigation
struct RootView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
            if viewModel.userSession != nil {
                ContentView()

            } else {
                LoginView()
            }
        
    }
}
#Preview {
    RootView().environmentObject(AuthViewModel())
}
