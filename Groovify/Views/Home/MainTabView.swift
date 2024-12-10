//
//  MainTabView.swift
//  Groovify
//
//  Created by David on 2024-12-09.
//

import SwiftUI

struct MainTabView: View {
    //ensert tab here
    enum Tab: Hashable {
        case home
        case input
    }
    //insert any view models needed here
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var musicPlayerManager = MusicPlayerManager()
    
    //tab flags
    @State private var selectedTab: Tab = .input //always starts at input view
    @State private var showMenu: Bool = false // Manage MenuView visibility
    
    var body: some View {
        let drag = DragGesture()
            .onEnded { value in
                if value.translation.width < -100 {
                    withAnimation {
                        showMenu = false
                    }
                }
            }

        return NavigationStack {
            GeometryReader { geometry in
                ZStack(alignment: .leading) { // Align MenuView to the left edge
                    // Main Content (TabView)
                    TabView(selection: $selectedTab) {
                        //MARK: - HOME TAB
                        HomeView(showMenu: $showMenu)
                            .environmentObject(authViewModel)
                            .environmentObject(musicPlayerManager)
                            .tabItem {
                                Label("Home", systemImage: selectedTab == .home ? "house.fill" : "house")
                            }
                            .tag(Tab.home)

                        //MARK: - INPUT TAB
                        InputView()
                            .tabItem {
                                Label("Input", systemImage: selectedTab == .input ? "music.microphone.circle.fill" : "music.microphone.circle")
                            }
                            .tag(Tab.input)
                        //MARK: - TBD

                    }
                    .offset(x: showMenu ? geometry.size.width / 2 : 0) // Slide content when menu is open
                    .disabled(showMenu) // Disable TabView interaction when menu is open

                    // MenuView Overlay
                    if showMenu {
                        MenuView()
                            .environmentObject(authViewModel)
                            .frame(width: geometry.size.width / 2)
                            .offset(x: showMenu ? 0 : -geometry.size.width / 2) // Start off-screen
                            .animation(.easeInOut, value: showMenu) // Smooth animation
                    }
                }
            }
            .gesture(drag) // Allow drag to close menu
            
            //Tab Controls
            .toolbar {
                // Menu Toggle Button (always on)
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        withAnimation {
                            showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                    }
                }
                
                
            }
        }
    }
}

#Preview {
    MainTabView().environmentObject(AuthViewModel())
}
