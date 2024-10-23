//
//  MapView.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/17/24.
//
import SwiftUI

struct MapView: View {
    @ObservedObject var mvm: MapViewModel
    @ObservedObject var gvm: GameViewModel
    
    var body: some View {
        ZStack {
            Image("png_image2_politica")
                .resizable()
                //.scaledToFill()
                .ignoresSafeArea(.all)
            VStack {
                // Display rectangles for all states in a 2x2 grid
                VStack {
                    HStack {
                        ForEach(mvm.mm.states.prefix(2), id: \.name) { state in
                            Rectangle()
                                .fill(state.color) // Set the rectangle's color
                                .frame(width: 100, height: 100)
                        }
                    }
                    HStack {
                        ForEach(mvm.mm.states.dropFirst(2), id: \.name) { state in
                            Rectangle()
                                .fill(state.color) // Set the rectangle's color
                                .frame(width: 100, height: 100)
                        }
                    }
                }
                
                VStack {
                    // Safely unwrap highestState
                    if let highestState = gvm.highestState {
                        Text("Highest Influence State:\n \(highestState.name) - \(highestState.baseColor.description), Influence: \(String(format: "%.2f", highestState.influence))")
                            .font(.headline)
                            .padding()
                    } else {
                        Text("No state with influence yet.")
                            .font(.headline)
                            .padding()
                    }
                    
                    ForEach(mvm.mm.states, id: \.name) { state in
                        Text("\(state.name) (\(state.baseColor)):\n Influence: \(String(format: "%.2f", state.influence))")
                    }
                }
            }
            .padding()
        }
        
    }
}

#Preview {
    let gameViewModel = GameViewModel()  // Create an instance of GameViewModel
    MapView(mvm: MapViewModel(gameViewModel: gameViewModel), gvm: gameViewModel)
}
