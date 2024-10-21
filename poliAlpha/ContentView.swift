//
//  ContentView.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/16/24.
//
import SwiftUI

struct ContentView: View {
    @StateObject var GameViewModel: GameViewModel
    @StateObject var MapViewModel: MapViewModel
    
    
    var body: some View {
        GameView()
    }
}

#Preview {
    ContentView(GameViewModel: GameViewModel(),
                MapViewModel: MapViewModel(
                    gameViewModel: GameViewModel()
                )
    )
}

