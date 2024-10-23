//
//  GameManager.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/17/24.
//

import Foundation
import Swift
import Metal

class GameLogic {
    
    static var timer: Timer?
    
    static func initializeTimer(){
        if MTLCreateSystemDefaultDevice() == nil {
            startTimer(with: GameViewModel())
        } else {
            isMetal.toggle()
            startMetalTimer(with: GameViewModel())
        }
    }
    
    static func startMetalTimer(with gameState: GameViewModel) {
        let metalTest = MetalTest(gameViewModel: gameState)
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            let increments: [Float] = [
                Float.random(in: -0.9...10),
                Float.random(in: -0.1...10),
                Float.random(in: -0.1...10),
                Float.random(in: -0.1...10)
            ]
            metalTest.calculateInfluences(with: increments)
        }
    }
    
    static func startTimer(with gvm: GameViewModel) {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            // Update state influences with your logic
            gvm.gm.stateA.influence += Double.random(in: -0.9...10.0)
            gvm.gm.stateB.influence += Double.random(in: -0.1...10.0)
            gvm.gm.stateC.influence += Double.random(in: -0.1...10.0)
            gvm.gm.stateD.influence += Double.random(in: -0.1...10.0)
            // Update colors based on influences
            gvm.updateColorsBasedOnInfluence()
        }
    }
    
    static func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

