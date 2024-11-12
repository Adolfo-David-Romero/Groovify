//
//  GroovifyApp.swift
//  Groovify
//
//  Created by David Romero on 2024-10-30.
//

import SwiftUI
//import Firebase
@main
struct GroovifyApp: App {
    let persistenceController = PersistenceController.shared
    /*@StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }
     */

    var body: some Scene {
        WindowGroup {
//            ContentView() // commented out for testing
            InputScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
