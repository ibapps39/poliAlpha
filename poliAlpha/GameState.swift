//
//  GameState.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/16/24.
//

// Minimal Sideeffects, other than visuals

import Foundation
import SwiftUI

class GameState: ObservableObject {
    @Published var stateA: State = State(
        name: "stateA",
        baseColor: .red,
        color: .red,
        influence: 0.00
    )
    @Published var stateB: State = State(
        name: "stateB",
        baseColor: .blue,
        color: .blue,
        influence: 0.00
    )
    @Published var stateC: State = State(
        name: "stateC",
        baseColor: .green,
        color: .green,
        influence: 0.00
    )
    @Published var stateD: State = State(
        name: "stateD",
        baseColor: .yellow,
        color: .yellow,
        influence: 0.00
    )
    
    var highestInfluenceState: State? {
        let states = [stateA, stateB, stateC, stateD]
        return states.max(by: { $0.influence < $1.influence })
    }
    
    func updateColorsBasedOnInfluence() {
        let states = [stateA, stateB, stateC, stateD]
        guard let (highestState, highestInfluence) = getHighestInfluence(states) else { return }
        
        for index in 0..<states.count {
            var state = states[index]
            if state.influence < highestInfluence {
                let influenceDifference = highestInfluence - state.influence
                let percentage = influenceDifference / highestInfluence
                
                // Adjust the color based on the percentage difference
                state.color = blendColor(state.baseColor, with: highestState.baseColor, percentage: percentage)
                
                // Update the state back to the array
                switch index {
                case 0: stateA = state
                case 1: stateB = state
                case 2: stateC = state
                case 3: stateD = state
                default: break
                }
            }
        }
    }
    
    func getHighestInfluence(_ states: [State]) -> (State, Double)? {
        var highestState: State?
        var highestInfluence: Double = 0
        
        for state in states {
            if state.influence > highestInfluence {
                highestInfluence = state.influence
                highestState = state
            }
        }
        
        guard let state = highestState else { return nil }
        return (state, highestInfluence)
    }
    
    private func blendColor(_ baseColor: Color, with targetColor: Color, percentage: Double) -> Color {
        // Extract RGB components from both colors
        let baseComponents = UIColor(baseColor).cgColor.components ?? [0, 0, 0, 0]
        let targetComponents = UIColor(targetColor).cgColor.components ?? [0, 0, 0, 0]
        
        // Blend the colors based on the percentage
        let r = baseComponents[0] + (targetComponents[0] - baseComponents[0]) * CGFloat(percentage)
        let g = baseComponents[1] + (targetComponents[1] - baseComponents[1]) * CGFloat(percentage)
        let b = baseComponents[2] + (targetComponents[2] - baseComponents[2]) * CGFloat(percentage)
        
        return Color(red: Double(r), green: Double(g), blue: Double(b))
    }
}
