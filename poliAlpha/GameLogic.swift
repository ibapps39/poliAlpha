//
//  GameLogic.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/16/24.
//

// Essenetially where sideeffects happen
import Foundation
import Swift

class GameLogic {
    static var timer: Timer?
    
    static func startTimer(with gameState: GameState) {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            // Update state influences with your logic
            gameState.stateA.influence += Double.random(in: -0.9...10.0)
            gameState.stateB.influence += Double.random(in: -0.1...10.0)
            gameState.stateC.influence += Double.random(in: -0.1...10.0)
            gameState.stateD.influence += Double.random(in: -0.1...10.0)

            // Update colors based on influences
            gameState.updateColorsBasedOnInfluence()
        }
    }
    
    static func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

