//
//  GameView.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/21/24.
//
import SwiftUI

struct GameView: View {
    @ObservedObject var gvm: GameViewModel
    @State private var selectedTab = 1 // Index for the MapView tab
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PolicyView()
                .tabItem {
                    Label("Policies", systemImage: "doc.plaintext")
                }
                .tag(0)
            
                // Pass the existing gvm to MapViewModel
                MapView(mvm: MapViewModel(gameViewModel: gvm), gvm: gvm)
                    .tabItem {
                        Label("Map", systemImage: "map")
                    }
                    .tag(1)
            
            LobbyView()
                .tabItem {
                    Label("Actions", systemImage: "star")
                }
                .tag(2)
            
            DebugMenu()
                .tabItem {
                    Label("Debug", systemImage: "computer")
                }
                .tag(3)
            
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .ignoresSafeArea(.all)
        .onAppear {
            GameLogic.startTimer(with: gvm)
        }
    }
}

#Preview {
    let gameViewModel = GameViewModel()
    GameView(gvm: gameViewModel)
}
