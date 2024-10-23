#  Additional Considerations
## MetalTest
### Mutex - GPT w/Swift6 doc regarding sync'ing and curious about how it realtes to Dispatch
``` Swift
private let mutex = Mutex()

private func updateInfluences() {
    let stateAInf = stateABuffer.contents().load(as: Float.self)
    let stateBInf = stateBBuffer.contents().load(as: Float.self)
    let stateCInf = stateCBuffer.contents().load(as: Float.self)
    let stateDInf = stateDBuffer.contents().load(as: Float.self)
    
    // Lock to ensure thread safety when accessing gameViewModel
    mutex.lock()
    DispatchQueue.main.async {
        self.gameViewModel.stateA.influence += Double(stateAInf)
        self.gameViewModel.stateB.influence += Double(stateBInf)
        self.gameViewModel.stateC.influence += Double(stateCInf)
        self.gameViewModel.stateA.influence += Double(stateDInf)
        
        self.gameViewModel.updateColorsBasedOnInfluence()
    }
    mutex.unlock()
}
```
### or without Mutex's overhead... (this code is from gpt so I've not yet tested it/written it)
struct AtomicDouble {
    private var value: Double
    private let queue = DispatchQueue(label: "com.example.AtomicDouble")
    
    init(_ value: Double) {
        self.value = value
    }
    
    func get() -> Double {
        return queue.sync { value }
    }
    
    mutating func add(_ increment: Double) {
        queue.sync {
            value += increment
        }
    }
}

class GameViewModel {
    var stateA = AtomicDouble(0)
    // Other states...
    
    func updateColorsBasedOnInfluence() {
        // Update logic...
    }
}


