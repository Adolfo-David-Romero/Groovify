//
//  GroovifyApp.swift
//  Groovify
//
//  Created by David Romero on 2024-10-30.
//

import SwiftUI

@main
struct GroovifyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView() // commented out for testing
            HomeView()
//            InputScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
