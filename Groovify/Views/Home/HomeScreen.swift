//
//  HomeScreen.swift
//  Groovify
//
//  Created by David on 2024-12-09.
//

import SwiftUI

///Home screen is used to overlay hamburger menu on homeview (MenuView)
struct HomeScreen: View {
    @State var showMenu = false
    var body: some View {
        let drag = DragGesture() //drag to close
            .onEnded{
                if $0.translation.width < -100{
                    withAnimation{
                        self.showMenu = false
                    }
                }
            }
        return NavigationStack{
            GeometryReader{ geometry in
                HomeView(showMenu: self.$showMenu).frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.showMenu ?
                            geometry.size.width/2 : 0)
                    .disabled(self.showMenu ? true : false)
                if self.showMenu{
                    MenuView()
                        .frame(width: geometry.size.width/2)
                        .transition(.move(edge: .leading))
                }
            }
            .gesture(drag)
        }.navigationTitle("Side Menu")
            .toolbar{
                ToolbarItem(placement: .topBarLeading, content: {
                    Button(action: {
                        withAnimation {
                            self.showMenu.toggle()
                        }
                    }, label: {
                        Image(systemName: "line.horizontal.3").imageScale(.large)
                    })
                }
                            
                )
            }
    }
}

#Preview {
    HomeScreen()
}
