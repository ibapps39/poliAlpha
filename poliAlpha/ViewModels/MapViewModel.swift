//
//  MapViewModel.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/17/24.
//

import Foundation
import SwiftUI
import Combine

class MapViewModel: ObservableObject {
    @Published var states: [StateModel] = []
    @Published var highestInfluenceState: StateModel?

    private var gameState: GameViewModel
    
    init(gameState: GameViewModel) {
        self.gameState = gameState
        self.states = [gameState.stateA, gameState.stateB, gameState.stateC, gameState.stateD]
        updateHighestInfluenceState()
        
        // Subscribe to changes in GameViewModel
        gameState.$stateA
            .merge(with: gameState.$stateB, gameState.$stateC, gameState.$stateD)
            .sink { [weak self] _ in
                self?.updateStates()
            }
            .store(in: &cancellables)
    }

    private func updateStates() {
        self.states = [gameState.stateA, gameState.stateB, gameState.stateC, gameState.stateD]
        updateHighestInfluenceState()
    }

    private func updateHighestInfluenceState() {
        highestInfluenceState = states.max(by: { $0.influence < $1.influence })
    }
    
    // Cancellables for Combine
    private var cancellables: Set<AnyCancellable> = []
}

