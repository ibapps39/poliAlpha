//
//  PolicyViewModel.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/17/24.
//

import Foundation

class PolicyViewModel: ObservableObject {
    // List of policies in the game
    @Published var policies: [PolicyModel]
    
    // Reference to the GameViewModel to update the game's state
    @Published var gameViewModel: GameViewModel

    init(gameViewModel: GameViewModel) {
        self.gameViewModel = gameViewModel
        
        // Initialize policies (sample policies)
        self.policies = [
            PolicyModel(name: "Increase Taxes", description: "Increase state taxes to fund government programs", baseInfluenceModifier: 0.1, isEnabled: true, cost: 50),
            PolicyModel(name: "Cut Military Spending", description: "Cut the defense budget to free up funds for other programs", baseInfluenceModifier: -0.05, isEnabled: true, cost: 30),
            PolicyModel(name: "Universal Healthcare", description: "Introduce a universal healthcare program", baseInfluenceModifier: 0.2, isEnabled: false, cost: 100)
        ]
    }

    // Toggle a policy's enabled state
    func togglePolicy(_ policy: PolicyModel) {
        if let index = policies.firstIndex(where: { $0.name == policy.name }) {
            policies[index].isEnabled.toggle()
        }
    }

    // Apply the policy's effect on the game
    func applyPolicy(_ policy: PolicyModel) {
        // Check if policy is enabled
        guard policy.isEnabled else { return }
        
        // Apply the influence modifier from the policy to the game model's influence
        gameViewModel.gm.campInfluence += policy.baseInfluenceModifier
        
        // Handle the cost of the policy
        if gameViewModel.gm.campCash >= policy.cost {
            gameViewModel.gm.campCash -= policy.cost
        } else {
            print("Not enough funds to apply policy: \(policy.name)")
        }
        
        // Optionally, you could trigger a re-render of the states here or trigger any other updates
        gameViewModel.updateColorsBasedOnInfluence()
    }

    // Helper to fetch policies that are enabled
    func enabledPolicies() -> [PolicyModel] {
        return policies.filter { $0.isEnabled }
    }

}
