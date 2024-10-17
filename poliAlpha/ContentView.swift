import SwiftUI

struct ContentView: View {
    @StateObject private var gameState = GameViewModel()
    @State private var selectedTab = 1 // Index for the MapView tab

    var body: some View {
        TabView(selection: $selectedTab) {
            PolicyView()
                .tabItem {
                    Label("Policies", systemImage: "doc.plaintext")
                }
                .tag(0) // Tag for the Policies tab

            MapView(viewModel: MapViewModel(gameState: gameState))
                .tabItem {
                    Label("Map", systemImage: "map")
                }
                .tag(1) // Tag for the Map tab

            LobbyView()
                .tabItem {
                    Label("Actions", systemImage: "star")
                }
                .tag(2) // Tag for the Actions tab
        }
        .onAppear {
            GameLogic.startTimer(with: gameState)
        }
    }
}

#Preview {
    ContentView()
}
