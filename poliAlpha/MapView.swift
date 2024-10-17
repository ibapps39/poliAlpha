//
//  MapView.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/17/24.
//
import SwiftUI

struct MapView: View {
    @ObservedObject var viewModel: MapViewModel

    var body: some View {
        VStack {
            HStack {
                ForEach(viewModel.states.prefix(2), id: \.name) { state in
                    Rectangle()
                        .fill(state.color)
                        .frame(width: 100, height: 100)
                }
            }
            HStack {
                ForEach(viewModel.states.suffix(2), id: \.name) { state in
                    Rectangle()
                        .fill(state.color)
                        .frame(width: 100, height: 100)
                }
            }
            VStack {
                if let highestState = viewModel.highestInfluenceState {
                    Text("Highest Influence State:\n \(highestState.name) - \(highestState.baseColor.description), Influence: \(String(format: "%.2f", highestState.influence))")
                        .font(.headline)
                        .padding()
                }
                ForEach(viewModel.states, id: \.name) { state in
                    Text("\(state.name) (\(state.baseColor)):\n Influence: \(String(format: "%.2f", state.influence))")
                }
            }
        }
        .padding()
    }
}

