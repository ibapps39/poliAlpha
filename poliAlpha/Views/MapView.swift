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
            Color(red: 100/255, green: 49/255, blue: 60/255)
                .ignoresSafeArea(.all)
            VStack {
                if let highestState = gvm.highestState {
                    Text("Highest Influence State:\n \(highestState.name) - \(highestState.baseColor.description), Influence: \(String(format: "%.2f", highestState.influence))")
                        .font(.headline)
                        .padding()
                        .foregroundStyle(.white)
                } else {
                    Text("No state with influence yet.")
                        .font(.headline)
                        .padding()
                        .background(Color(red: 0.0, green: 49/255, blue: 83/255))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                        .foregroundStyle(.white)
                }
                // Display first two states
                VStack {
                    HStack {
                        ForEach(mvm.mm.states.prefix(2), id: \.name) { state in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(state.color) // Set the rectangle's color
                                .frame(width: 100, height: 100)
                        }
                    }
                    // Display last two states
                    HStack {
                        ForEach(mvm.mm.states.dropFirst(2), id: \.name) { state in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(state.color) // Set the rectangle's color
                                .frame(width: 100, height: 100)
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    ForEach(mvm.mm.states, id: \.name) { state in
                        HStack {
                            Text("\(state.name) (")
                                .foregroundColor(.white)
                            Text("\(state.baseColor.description)")
                                .foregroundColor(state.baseColor)
                            Text("): Influence: ")
                                .foregroundColor(.white)
                            Text("\(String(format: "%.2f", state.influence))")
                                .foregroundColor(state.baseColor)
                        }
                        .padding()
                        .background(Color(red: 0.0, green: 49/255, blue: 83/255))
                        .bold()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding()
                .foregroundStyle(.white)
            }
            .padding()
        }
        
    }
}

#Preview {
    let gameViewModel = GameViewModel()  // Create an instance of GameViewModel
    MapView(mvm: MapViewModel(gameViewModel: gameViewModel), gvm: gameViewModel)
}
