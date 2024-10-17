//
//  ContentView.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/16/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var gameState = GameState()
    
    var body: some View {
        let stateA = gameState.stateA
        let stateB = gameState.stateB
        let stateC = gameState.stateC
        let stateD = gameState.stateD
        
        VStack {
            HStack {
                Rectangle()
                    .fill(stateA.color)
                    .frame(width: 100, height: 100)
                Rectangle()
                    .fill(stateB.color)
                    .frame(width: 100, height: 100)
            }
            HStack {
                Rectangle()
                    .fill(stateC.color)
                    .frame(width: 100, height: 100)
                Rectangle()
                    .fill(stateD.color)
                    .frame(width: 100, height: 100)
            }
            VStack {
                // Display the state with the highest influence
                if let highestState = gameState.highestInfluenceState {
                    Text("Highest Influence State:\n \(highestState.name) - \(highestState.baseColor.description), with Influence: \(String(format: "%.2f", highestState.influence))")
                        .font(.headline)
                        .padding()
                }
                Text("State A (\(stateA.baseColor)):\n Influence:\(String(format: "%.2f", stateA.influence))")
                Text("State B (\(stateB.baseColor)):\n Influence:\(String(format: "%.2f", stateB.influence))")
                Text("State C (\(stateC.baseColor)):\n Influence:\(String(format: "%.2f", stateC.influence))")
                Text("State D (\(stateD.baseColor)):\n Influence:\(String(format: "%.2f", stateD.influence))")
            }
        }
        .onAppear {
            GameLogic.startTimer(with: gameState)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
