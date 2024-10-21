//
//  GameModel.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/21/24.
//

import Foundation

struct GameModel {
    var stateA: StateModel
    var stateB: StateModel
    var stateC: StateModel
    var stateD: StateModel
    
    var campCash: Int
    var campInfluence: Double
    
    var highestInfluenceState: StateModel? 
}
