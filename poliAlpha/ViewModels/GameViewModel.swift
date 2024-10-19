//
//  GameViewModel.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/17/24.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var stateA: StateModel = StateModel(
        name: "stateA",
        baseColor: .red,
        color: .red,
        influence: 0.00
    )
    @Published var stateB: StateModel = StateModel(
        name: "stateB",
        baseColor: .blue,
        color: .blue,
        influence: 0.00
    )
    @Published var stateC: StateModel = StateModel(
        name: "stateC",
        baseColor: .green,
        color: .green,
        influence: 0.00
    )
    @Published var stateD: StateModel = StateModel(
        name: "stateD",
        baseColor: .yellow,
        color: .yellow,
        influence: 0.00
    )
    
    @Published var campCash: Int = 100
    
    @Published var campInfluence: Double = 0.00
    
    var highestInfluenceState: StateModel? {
        let states = [stateA, stateB, stateC, stateD]
        return states.max(by: { $0.influence < $1.influence })
    }
    
    func updateColorsBasedOnInfluence() {
        let states = [stateA, stateB, stateC, stateD]
        guard let (highestState, highestInfluence) = getHighestInfluence(states) else { return }
        
        for index in 0..<states.count {
            var StateModel = states[index]
            if StateModel.influence < highestInfluence {
                let influenceDifference = highestInfluence - StateModel.influence
                let percentage = influenceDifference / highestInfluence
                
                // Adjust the color based on the percentage difference
                StateModel.color = blendColor(StateModel.baseColor, with: highestState.baseColor, percentage: percentage)
                
                // Update the StateModel back to the array
                switch index {
                case 0: stateA = StateModel
                case 1: stateB = StateModel
                case 2: stateC = StateModel
                case 3: stateD = StateModel
                default: break
                }
            }
        }
    }
    
    func getHighestInfluence(_ states: [StateModel]) -> (StateModel, Double)? {
        var highestState: StateModel?
        var highestInfluence: Double = 0
        
        for StateModel in states {
            if StateModel.influence > highestInfluence {
                highestInfluence = StateModel.influence
                highestState = StateModel
            }
        }
        
        guard let StateModel = highestState else { return nil }
        return (StateModel, highestInfluence)
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
