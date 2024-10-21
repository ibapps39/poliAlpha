//
//  GameView.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/21/24.
//
import SwiftUI

struct GameView: View {
    @StateObject private var gvm = GameViewModel()
    
    @State private var selectedTab = 1 // Index for the MapView tab
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PolicyView()
                .tabItem {
                    Label("Policies", systemImage: "doc.plaintext")
                }
                .tag(0) // Tag for the Policies tab
            
            MapView(mvm: MapViewModel(gameViewModel: gvm))
                .tabItem {
                    Label("Map", systemImage: "map")
                }
                .tag(1) // Tag for the Map tab
            
            LobbyView()
                .tabItem {
                    Label("Actions", systemImage: "star")
                }
                .tag(2) // Tag for the Actions tab
        }
        .onAppear {
            GameLogic.startTimer(with: gvm)
        }
        VStack {
            // Display game state data
            ForEach([gvm.gm.stateA,
                     gvm.gm.stateB,
                     gvm.gm.stateC,
                     gvm.gm.stateD],
                    id: \.name)
            { state in
                Text("\(state.name): Influence: \(state.influence)")
                    .foregroundColor(state.color)
            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
