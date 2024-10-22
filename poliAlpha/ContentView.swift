//
//  ContentView.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/16/24.
//
import SwiftUI

struct ContentView: View {
    
    @StateObject private var gvm = GameViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to PoliAlpha!")
                    .font(.largeTitle)
                    .padding()

                NavigationLink(destination: GameView(gvm: gvm)) {
                    Text("Start Game")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                // You can add more navigation links or features here
            }
            .navigationTitle("Main Menu")
        }
    }
}

#Preview {
    ContentView()
}

