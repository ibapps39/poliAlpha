//
//  MapView.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/17/24.
//
import SwiftUI

struct MapView: View {
    @ObservedObject var mvm: MapViewModel
    
    var body: some View {
        VStack {
            HStack {
                ForEach(mvm.mm.states.prefix(1), id: \.name) { state in
                    Rectangle()
                        .fill()
                        .frame(width: 100, height: 100)
                }
            }
            HStack {
                ForEach(mvm.mm.states.prefix(2), id: \.name) { state in
                    Rectangle()
                        .fill()
                        .frame(width: 100, height: 100)
                }
            }
            VStack {
                Text("Highest Influence State:\n \(highestState.name) - \(highestState.baseColor.description), Influence: \(String(format: "%.2f", highestState.influence))")
                    .font(.headline)
                    .padding()
                ForEach(mvm.states, id: \.name) { state in
                    Text("\(state.name) (\(state.baseColor)):\n Influence: \(String(format: "%.2f", state.influence))")
                }
            }
        }
        .padding()
    }
}

#Preview {
    
    MapView(mvm: MapViewModel(gameViewModel: GameViewModel())
    )
}
