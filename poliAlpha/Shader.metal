//
//  Shader.metal
//  poliAlpha
//
//  Created by Ian Brown on 10/19/24.
//

#include <metal_stdlib>
using namespace metal;

kernel void updateInfluences(
    device float* stateAInfluence [[buffer(0)]],
    device float* stateBInfluence [[buffer(1)]],
    device float* stateCInfluence [[buffer(2)]],
    device float* stateDInfluence [[buffer(3)]],
    device float* passedIncrement [[buffer(4)]],
    uint id [[thread_position_in_grid]])
{
    if (id < 1) { // Assuming one thread for each state
        stateAInfluence[id] += passedIncrement[0];
        stateBInfluence[id] += passedIncrement[1];
        stateCInfluence[id] += passedIncrement[2];
        stateDInfluence[id] += passedIncrement[3];
    }
}


