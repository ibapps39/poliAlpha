//
//  MetalTest.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/19/24.
//

import Foundation
import Metal

class MetalTest {
    // Metal Setup
    var device: MTLDevice!
    var commandQueue: MTLCommandQueue!
    var computePipelineState: MTLComputePipelineState!
    
    // 1 thread per state
    var stateABuffer: MTLBuffer!
    var stateBBuffer: MTLBuffer!
    var stateCBuffer: MTLBuffer!
    var stateDBuffer: MTLBuffer!
    
    var incrementBuffer: MTLBuffer!
    
    var gameViewModel: GameViewModel // Store a reference to the GameViewModel
    
    init(gameViewModel: GameViewModel) {
        self.gameViewModel = gameViewModel // Initialize the reference
        setupMetal()
    }
    
    func setupMetal() {
        device = MTLCreateSystemDefaultDevice()!
        
        commandQueue = device.makeCommandQueue()
        
        let library = device.makeDefaultLibrary()!
        
        let function = library.makeFunction(name: "incrementInfluence")
        computePipelineState = try! device.makeComputePipelineState(function: function!)
        
        stateABuffer = device.makeBuffer(length: MemoryLayout<Float>.size)
        stateBBuffer = device.makeBuffer(length: MemoryLayout<Float>.size)
        stateCBuffer = device.makeBuffer(length: MemoryLayout<Float>.size)
        stateDBuffer = device.makeBuffer(length: MemoryLayout<Float>.size)
        
        incrementBuffer = device.makeBuffer(length: MemoryLayout<Float>.size * 4)
    }
    
    func calculateInfluences(with increments: [Float]) {
        
        let incrementPointer = incrementBuffer.contents().bindMemory(to: Float.self, capacity: 4)
        incrementPointer.initialize(from: increments, count: increments.count)
        
        let commandBuffer = commandQueue.makeCommandBuffer()
        let computeCommandEncoder = commandBuffer?.makeComputeCommandEncoder()
        
        computeCommandEncoder?.setComputePipelineState(computePipelineState)
        
        computeCommandEncoder?.setBuffer(stateABuffer, offset: 0, index: 0)
        computeCommandEncoder?.setBuffer(stateBBuffer, offset: 0, index: 1)
        computeCommandEncoder?.setBuffer(stateCBuffer, offset: 0, index: 2)
        computeCommandEncoder?.setBuffer(stateDBuffer, offset: 0, index: 3)
        computeCommandEncoder?.setBuffer(incrementBuffer, offset: 0, index: 4)
        
        let threadGroupSize = MTLSize(width: 1, height: 1, depth: 1)
        let threadGroups = MTLSize(width: 1, height: 1, depth: 1)
        
        computeCommandEncoder?.dispatchThreadgroups(threadGroups, threadsPerThreadgroup: threadGroupSize)
        computeCommandEncoder?.endEncoding()
        
        commandBuffer?.addCompletedHandler { _ in
            self.updateInfluences()
        }
        
        commandBuffer?.commit()
    }
    private func updateInfluences() {
        let stateAInf = stateABuffer.contents().load(as: Float.self)
        let stateBInf = stateBBuffer.contents().load(as: Float.self)
        let stateCInf = stateCBuffer.contents().load(as: Float.self)
        let stateDInf = stateDBuffer.contents().load(as: Float.self)
        
        DispatchQueue.main.async {
            self.gameViewModel.gm.stateA.influence += Double(stateAInf)
            self.gameViewModel.gm.stateB.influence += Double(stateBInf)
            self.gameViewModel.gm.stateC.influence += Double(stateCInf)
            self.gameViewModel.gm.stateD.influence += Double(stateDInf)
            self.gameViewModel.updateColorsBasedOnInfluence()
        }
        
    }
}
