//
//  GameViewModel.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/17/24.
//

import Foundation
import Swift
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var gm: GameModel
    
    init() {
        gm = GameModel(
            stateA: StateModel(name: "stateA", baseColor: .red, color: .red, influence: 0.00),
            stateB: StateModel(name: "stateB", baseColor: .blue, color: .blue, influence: 0.00),
            stateC: StateModel(name: "stateC", baseColor: .green, color: .green, influence: 0.00),
            stateD: StateModel(name: "stateD", baseColor: .yellow, color: .yellow, influence: 0.00),
            campCash: 100,
            campInfluence: 0.00
        )
    }

    func updateColorsBasedOnInfluence() {
        let states = [gm.stateA, gm.stateB, gm.stateC, gm.stateD]
        guard let (highestState, highestInfluence) = getHighestInfluence(states) else { return }
        
        for index in 0..<states.count {
            var stateModel = states[index]
            if stateModel.influence < highestInfluence {
                let influenceDifference = highestInfluence - stateModel.influence
                let percentage = influenceDifference / highestInfluence
                
                // Adjust the color based on the percentage difference
                stateModel.color = blendColor(stateModel.baseColor, with: highestState.baseColor, percentage: percentage)
                
                // Update the StateModel back to the gm
                switch index {
                case 0: gm.stateA = stateModel
                case 1: gm.stateB = stateModel
                case 2: gm.stateC = stateModel
                case 3: gm.stateD = stateModel
                default: break
                }
            }
        }
    }

    private func getHighestInfluence(_ states: [StateModel]) -> (StateModel, Double)? {
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

