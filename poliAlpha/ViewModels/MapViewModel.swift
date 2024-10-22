//
//  MapViewModel.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/17/24.
//

import SwiftUI


class MapViewModel: ObservableObject {
    
    @Published var mm: MapModel
    private var gvm: GameViewModel
    
    init(gameViewModel: GameViewModel) {
        self.gvm = gameViewModel
        self.mm = MapModel(
            states: [
                gvm.gm.stateA,
                gvm.gm.stateB,
                gvm.gm.stateC,
                gvm.gm.stateD]
        )
    }
}
